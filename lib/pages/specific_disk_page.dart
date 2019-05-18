import 'dart:convert';

import 'package:flutter/material.dart';

import '../API/api.dart';
import '../models/disk.dart';

class SpecificDiskPage extends StatefulWidget {
  SpecificDiskPage({Key key, this.diskId}) : super(key: key);

  final int diskId;

  @override
  _SpecificDiskPageState createState() => _SpecificDiskPageState();
}

class _SpecificDiskPageState extends State<SpecificDiskPage> {
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
        title: Text('Disk'),
      ),
      body: Center(
        child: FutureBuilder(
          future: API.fetchDisk(widget.diskId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Text(snapshot.data.id.toString()),
                  Text(snapshot.data.name),
                  Text(snapshot.data.volumeLable),
                  Text(snapshot.data.isReady.toString()),
                  Text(snapshot.data.driveType),
                  Text(snapshot.data.driveFormat),
                  Text(snapshot.data.totalSize.toString()),
                  Text(snapshot.data.totalFreeSpace.toString()),
                  Text(snapshot.data.availableFreeSpace.toString()),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
