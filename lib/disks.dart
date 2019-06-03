import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './models/basic_disk.dart';
import './pages/specific_disk_page.dart';
import './pages/settings_page.dart';

class Disks extends StatelessWidget {
  Disks({this.diskFuture});

  final Future diskFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: diskFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return new Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Couldn't find any disks!"),
                    Text(
                        'Check if you have set your API link on the settings page.'),
                    RaisedButton(
                      child: Text('Settings'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPage(
                                    title: 'Settings',
                                  ),
                            ));
                      },
                    )
                  ],
                ),
              );
            } else {
              return createListView(context, snapshot);
            }
        }
      },
    );
  }

  Widget imageSection(String imageUrl) {
    return Container(
      height: 100.0,
      child: Image.asset(imageUrl),
    );
  }

  Widget infoSection(BasicDiskInfo info) {
    double percentage(int totalSize, int totalFreeSpace) {
      return (100.0 -
          ((info.totalFreeSpace / info.totalSize) * 100).toDouble());
    }

    double _percentage = percentage(info.totalSize, info.totalFreeSpace);

    Color colorPercentage(_percentage) {
      if (_percentage >= 75 && _percentage <= 89) {
        return Colors.orange;
      } else if (_percentage >= 90) {
        return Colors.red;
      }

      return Colors.green;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(info.name),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(info.driveType),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(info.driveFormat),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text('Capacity is ${_percentage.toStringAsFixed(2)}% full'),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: LinearProgressIndicator(
              value: percentage(info.totalSize, info.totalFreeSpace) * 0.01,
              valueColor: AlwaysStoppedAnimation<Color>(colorPercentage(
                  percentage(info.totalSize, info.totalFreeSpace))),
            ),
          ),
        ],
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<BasicDiskInfo> disks = snapshot.data;
    String imageUrl;
    return new ListView.builder(
      itemCount: disks.length,
      itemBuilder: (context, index) {
        switch (disks[index].driveType) {
          case 'Fixed':
            if (disks[index].name == 'C:\\') {
              imageUrl = 'assets/icons/os_disk.png';
            } else {
              imageUrl = 'assets/icons/disk.png';
            }
            break;
          case 'Network':
            imageUrl = 'assets/icons/network_disk.png';
            break;
          default:
            imageUrl = 'assets/icons/disk.png';
            break;
        }
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
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
            child: Row(
              children: <Widget>[
                imageSection(imageUrl),
                Expanded(
                  child: infoSection(disks[index]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
