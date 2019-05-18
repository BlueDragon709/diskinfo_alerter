import 'package:flutter/material.dart';

import '../disks.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
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
        child: Disks(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('hi'),
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
