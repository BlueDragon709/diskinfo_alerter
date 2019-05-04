import 'package:flutter/material.dart';

import './models/disk_info.dart';

class Disks extends StatelessWidget {
  final List<DiskInfo> disks;

  Disks([this.disks = const []]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: disks
          .map((element) => Card(
                child: Column(
                  children: <Widget>[
                    Text(element.name),
                    Text(element.totalSize.toString()),
                    Text(element.totalFreeSpace.toString()),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
