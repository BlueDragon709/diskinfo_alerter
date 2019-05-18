import 'package:diskinfo_alerter/models/basic_disk.dart';
import 'package:flutter/material.dart';

import './API/api.dart';
import './pages/specific_disk_page.dart';

class Disks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: API.fetchAllDisks(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return new Text('Error: ${snapshot.error}');
            } else {
              print(snapshot.data);
              return createListView(context, snapshot);
            }
        }
      },
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<BasicDiskInfo> disks = snapshot.data;
    return new ListView.builder(
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
