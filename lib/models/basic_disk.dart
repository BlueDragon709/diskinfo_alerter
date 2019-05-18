import 'dart:core';

class BasicDiskInfo {
  int id;
  String name;
  String driveType;
  String driveFormat;
  int totalSize;
  int totalFreeSpace;

  BasicDiskInfo(
      {this.id,
      this.name,
      this.driveType,
      this.driveFormat,
      this.totalSize,
      this.totalFreeSpace});

  BasicDiskInfo.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        driveType = json['driveType'],
        driveFormat = json['driveFormat'],
        totalSize = json['totalSize'],
        totalFreeSpace = json['totalFreeSpace'];
}
