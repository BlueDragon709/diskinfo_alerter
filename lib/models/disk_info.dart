import 'dart:core';

class DiskInfo {
  String name;
  String driveType;
  String driveFormat;
  int totalSize;
  int totalFreeSpace;

  DiskInfo(
      {this.name,
      this.driveType,
      this.driveFormat,
      this.totalSize,
      this.totalFreeSpace});

  DiskInfo.fromJson(Map json)
      : name = json['name'],
        driveType = json['driveType'],
        driveFormat = json['driveFormat'],
        totalSize = json['totalSize'],
        totalFreeSpace = json['totalFreeSpace'];
}
