import 'package:flutter/material.dart';

import '../API/api.dart';

class SpecificDiskPage extends StatelessWidget {
  SpecificDiskPage({Key key, this.diskId}) : super(key: key);

  final int diskId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disk'),
      ),
      body: Center(
        child: FutureBuilder(
          future: API.fetchDisk(diskId),
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
