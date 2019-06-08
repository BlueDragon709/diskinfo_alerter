import 'package:diskinfo_alerter/models/basic_disk.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../disks.dart';
import '../models/choice.dart';
import '../API/api.dart';
import './settings_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Choice _selectedChoice = choices[0];

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsPage(
                title: _selectedChoice.title,
              ),
        ));
  }

  Future<List<BasicDiskInfo>> _future;

  @override
  void initState() {
    super.initState();
    _future = API.fetchAllDisks().timeout(Duration(seconds: 5));

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );

    _firebaseMessaging.subscribeToTopic("all");
  }

  update(String token) {
    print(token);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(choices[0].icon),
            onPressed: () {
              _select(choices[0]);
            },
          )
        ],
      ),
      body: Center(
        child: Disks(
          diskFuture: _future,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _future = API.fetchAllDisks().timeout(Duration(seconds: 5));
          });
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Settings', icon: Icons.settings)
];
