import 'package:flutter/material.dart';

import './models/basic_disk.dart';
import './pages/specific_disk_page.dart';

class Disks extends StatelessWidget {
  final List<BasicDiskInfo> disks;

  Disks({this.disks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: disks.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpecificDiskPage(
                        diskId: disks[index].id,
                      ),
                ));
          },
          child: Card(
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
          ),
        );
      },
    );
  }
}
