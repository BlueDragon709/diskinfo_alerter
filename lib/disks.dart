import 'package:flutter/material.dart';

import './models/disk_info.dart';

class Disks extends StatelessWidget {
  final List<DiskInfo> disks;

  Disks({this.disks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: disks.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(disks[index].name),
                  Spacer(),
                  Text(disks[index].driveType),
                  Spacer(),
                  Text(disks[index].driveFormat),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(disks[index].totalSize.toString()),
                  Spacer(),
                  Text(disks[index].totalFreeSpace.toString()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
