import 'dart:convert';

import 'package:flutter/material.dart';

import '../disks.dart';
import '../API/api.dart';
import '../models/basic_disk.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BasicDiskInfo> _disks = new List<BasicDiskInfo>();

  @override
  void initState() {
    super.initState();
    _getDisks();
  }

  _getDisks() {
    API.getDisks().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        _disks = list.map((model) => BasicDiskInfo.fromJson(model)).toList();
      });
    });
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
      ),
      body: Center(
        child: Disks(
          disks: _disks,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getDisks,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
