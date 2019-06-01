import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:diskinfo_alerter/models/basic_disk.dart';
import 'package:diskinfo_alerter/models/disk.dart';

/// A class for all calls to the DiskInfoAPI
class API {
  static Future getData(String url) {
    return http.get('http://192.168.2.8:5000/api/' + url);
    //return http.get('http://172.27.1.148:5000/api/' + url);
  }

  static Future<List<BasicDiskInfo>> fetchAllDisks() async {
    final response = await getData('disk');

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<BasicDiskInfo> disks =
          list.map((model) => BasicDiskInfo.fromJson(model)).toList();
      return disks;
    } else {
      throw Exception('Failed to load disks');
    }
  }

  static Future<Disk> fetchDisk(int id) async {
    final response = await getData('disk/' + id.toString());

    if (response.statusCode == 200) {
      return Disk.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load disk');
    }
  }
}
