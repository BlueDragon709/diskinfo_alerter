import 'package:flutter/material.dart';
import '../settings_form.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SettingsForm(),
    );
  }
}
