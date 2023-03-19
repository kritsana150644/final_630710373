import 'dart:convert';

import 'package:election_2566_poll/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/poll.dart';
import '../my_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Poll>? _polls;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    // todo: Load list of polls here
    var res = await ApiClient().getId();
    print(res.statusCode);
    if (res.statusCode == 200) {
      List result = jsonDecode();
      setState(() {
        _polls = result.map((item) => Poll.fromJson(item)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Image.network(
              'https://cpsu-test-api.herokuapp.com/images/election.jpg'),
          Expanded(
            child: Stack(
              children: [
                if (_polls != null) _buildList(),
                if (_isLoading) _buildProgress(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      itemCount: _polls!.length,
      itemBuilder: (BuildContext context, int index) {
        // todo: Create your poll item by replacing this Container()
        var polls = _polls![index];
        return Container(
          child: Row(
            children: [
              Text('${polls.id.toString()}.'),
              //TextButton(onPressed: () {}, child: Text('${polls.choices}')),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgress() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.white),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('รอสักครู่', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

// Widget _buildListItem(BuildContext context, int index){
//   var polls = _polls![index];
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Container(
//       //margin: const EdgeInsets.all(8.0),
//       color: Colors.white10,
//       child: Row(
//         children: [
//           Text('${polls.id.toString()}.${polls.choices}')
//         ],
//       ),
//     ),
//   );
// }
}
