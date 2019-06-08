import 'package:flutter/material.dart';

import '../models/disk.dart';
import '../API/api.dart';

class SpecificDiskPage extends StatelessWidget {
  SpecificDiskPage({Key key, this.diskId, this.imageString}) : super(key: key);

  final int diskId;
  final String imageString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disk'),
      ),
      body: Center(
        child: FutureBuilder(
          future: API.fetchDisk(diskId),
          builder: (BuildContext context, AsyncSnapshot<Disk> snapshot) {
            if (snapshot.hasData) {
              Disk _disk = snapshot.data;
              return Column(
                children: <Widget>[
                  imageSection(imageString),
                  Text(_disk.id.toString()),
                  Text(_disk.name),
                  Text(_disk.volumeLable),
                  Text(_disk.isReady.toString()),
                  Text(_disk.driveType),
                  Text(_disk.driveFormat),
                  Text(_disk.totalSize.toString()),
                  Text(_disk.totalFreeSpace.toString()),
                  Text(_disk.availableFreeSpace.toString()),
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

Widget imageSection(String image) => Container(
      child: RotatedBox(
        child: Image.asset(
          image,
          width: 240,
          height: 600,
          fit: BoxFit.cover,
        ),
        quarterTurns: 1,
      ),
    );
