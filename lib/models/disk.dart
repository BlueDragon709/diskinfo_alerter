import 'dart:core';

class Disk {
  int id;
  String name;
  String volumeLable;
  bool isReady;
  String driveType;
  String driveFormat;
  int totalSize;
  int totalFreeSpace;
  int availableFreeSpace;

  Disk(
      {this.id,
      this.name,
      this.volumeLable,
      this.isReady,
      this.driveType,
      this.driveFormat,
      this.totalSize,
      this.totalFreeSpace,
      this.availableFreeSpace});

  factory Disk.fromJson(Map<String, dynamic> json) {
    return Disk(
        id: json['id'],
        name: json['name'],
        volumeLable: json['volumeLable'],
        isReady: json['isReady'],
        driveType: json['driveType'],
        driveFormat: json['driveFormat'],
        totalSize: json['totalSize'],
        totalFreeSpace: json['totalFreeSpace'],
        availableFreeSpace: json['availableFreeSpace']);
  }
}
