import 'dart:core';

class DiskInfo {
  int id;
  String name;
  String driveType;
  String driveFormat;
  int totalSize;
  int totalFreeSpace;

  DiskInfo(
      {this.id,
      this.name,
      this.driveType,
      this.driveFormat,
      this.totalSize,
      this.totalFreeSpace});

  DiskInfo.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        driveType = json['driveType'],
        driveFormat = json['driveFormat'],
        totalSize = json['totalSize'],
        totalFreeSpace = json['totalFreeSpace'];
}
