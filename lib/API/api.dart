import 'dart:async';
import 'package:http/http.dart' as http;

class API {
  static Future getDisks() {
    return http.get('http://192.168.2.55:5000/api/disk');
  }
}
