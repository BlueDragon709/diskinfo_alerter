import 'package:flutter/material.dart';

import '../models/disk.dart';

class SpecificDiskPage extends StatefulWidget {
  SpecificDiskPage({Key key, this.diskId}) : super(key: key);

  final int diskId;

  @override
  _SpecificDiskPageState createState() => _SpecificDiskPageState();
}

class _SpecificDiskPageState extends State<SpecificDiskPage> {
  Disk disk;

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
    return Container();
  }
}
