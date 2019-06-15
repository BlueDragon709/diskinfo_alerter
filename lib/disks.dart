import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './styles.dart';

import './models/basic_disk.dart';
import './pages/specific_disk_page.dart';
import './pages/settings_page.dart';

class Disks extends StatelessWidget {
  Disks({this.diskFuture});

  final Future<List<BasicDiskInfo>> diskFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: diskFuture,
      builder:
          (BuildContext context, AsyncSnapshot<List<BasicDiskInfo>> snapshot) {
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
    List<Widget> widgets = [];

    widgets.add(Container(
      margin: Styles.listItemTextMargin,
      child: Text(info.name),
    ));

    widgets.add(Container(
      margin: Styles.listItemTextMargin,
      child: Text(info.driveType),
    ));
    percentageSection(info).forEach((e) => widgets.add(e));
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  List<Widget> percentageSection(BasicDiskInfo info) {
    double percentage(int totalSize, int totalFreeSpace) {
      return (100.0 -
          ((info.totalFreeSpace / info.totalSize) * 100).toDouble());
    }

    double _percentage = percentage(info.totalSize, info.totalFreeSpace);

    Color colorPercentage(_percentage) {
      if (_percentage >= 75 && _percentage < 90) {
        return Colors.orange;
      } else if (_percentage >= 90) {
        return Colors.red;
      }

      return Colors.green;
    }

    List<Widget> section = [];

    if (info.driveFormat != null) {
      section.add(Container(
        margin: Styles.listItemTextMargin,
        child: Text(info.driveFormat),
      ));
      section.add(Container(
        margin: Styles.listItemTextMargin,
        child: Text('Capacity is ${_percentage.toStringAsFixed(2)}% full'),
      ));
      section.add(Container(
        margin: EdgeInsets.all(10.0),
        child: LinearProgressIndicator(
          value: percentage(info.totalSize, info.totalFreeSpace) * 0.01,
          valueColor: AlwaysStoppedAnimation<Color>(
              colorPercentage(percentage(info.totalSize, info.totalFreeSpace))),
        ),
      ));
    } else {
      section.add(Container());
    }
    return section;
  }

  Widget createListView(
      BuildContext context, AsyncSnapshot<List<BasicDiskInfo>> snapshot) {
    List<BasicDiskInfo> disks = snapshot.data;
    List<String> imageUrls = [];
    bool clickable = true;
    return new ListView.builder(
      itemCount: disks.length,
      itemBuilder: (context, index) {
        switch (disks[index].driveType) {
          case 'Fixed':
            if (disks[index].name == 'C:\\') {
              imageUrls.insert(index, 'assets/icons/os_disk.png');
            } else {
              imageUrls.insert(index, 'assets/icons/disk.png');
            }
            break;
          case 'Network':
            imageUrls.insert(index, 'assets/icons/network_disk.png');
            break;
          default:
            imageUrls.insert(index, 'assets/icons/disk.png');
            break;
        }
        return GestureDetector(
          onTap: () {
            if (disks[index].driveFormat != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpecificDiskPage(
                          diskId: disks[index].id,
                          imageString: imageUrls[index],
                        ),
                  ));
            }
          },
          child: Card(
            margin: Styles.listItemMargin,
            child: Row(
              children: <Widget>[
                imageSection(imageUrls[index]),
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
