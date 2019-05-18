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

  factory BasicDiskInfo.fromJson(Map<String, dynamic> json) {
    return BasicDiskInfo(
        id: json['id'],
        name: json['name'],
        driveType: json['driveType'],
        driveFormat: json['driveFormat'],
        totalSize: json['totalSize'],
        totalFreeSpace: json['totalFreeSpace']);
  }

  // BasicDiskInfo.fromJson(Map json)
  //     : id = json['id'],
  //       name = json['name'],
  //       driveType = json['driveType'],
  //       driveFormat = json['driveFormat'],
  //       totalSize = json['totalSize'],
  //       totalFreeSpace = json['totalFreeSpace'];
}
