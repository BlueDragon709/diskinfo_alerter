import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:diskinfo_alerter/models/basic_disk.dart';
import 'package:diskinfo_alerter/models/disk.dart';

/// A class for all calls to the DiskInfoAPI
class API {
  static Future _getData(String url) async {
    String link = await _getApiLink();
    return http.get('http://' + link + ':5000/api/' + url);
  }

  static Future<List<BasicDiskInfo>> fetchAllDisks() async {
    final response = await _getData('disk');

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
    final response = await _getData('disk/' + id.toString());

    if (response.statusCode == 200) {
      return Disk.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load disk');
    }
  }

  static _getApiLink() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String link = (prefs.getString('link') ?? '1');
    return link;
  }
}
