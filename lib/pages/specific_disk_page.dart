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
              return Column(
                children: <Widget>[
                  imageSection(imageString),
                  infoSection(snapshot.data)
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

Widget imageSection(String image) {
  return Container(
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
}

Widget infoSection(Disk info) {
  Map<String, dynamic> _info = {
    'Name': info.name,
    'Lable': info.volumeLable,
    'Is ready': info.isReady,
    'Disk type': info.driveType,
    'Disk format': info.driveFormat,
    'Total size': info.totalSize,
    'Total free space': info.totalFreeSpace,
    'Available free space': info.availableFreeSpace
  };

  List<Widget> rows = [];

  _info.forEach((k, v) => rows.add(infoRow(k, v)));

  return Container(
    margin: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0.0),
    child: Column(
      children: rows,
    ),
  );
}

Widget infoRow(String rowName, dynamic rowData) {
  Widget dataWidget;
  if (rowData is int) {
    dataWidget = Text('${rowData.toString()} bytes');
  } else if (rowData is bool) {
    dataWidget = Text(rowData.toString());
  } else {
    dataWidget = Text(rowData);
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(rowName),
      dataWidget,
    ],
  );
}
