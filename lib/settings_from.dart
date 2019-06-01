import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  String exampleText;
  TextEditingController controller = new TextEditingController();

  void onChange() {
    setState(() {
      exampleText = controller.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _startUp();
    controller.addListener(onChange);
  }

  _startUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int timesStarted = (prefs.getInt('timesStarted') ?? 0) + 1;

    if (timesStarted > 1) {
      _getApiLink();
    } else {
      _setApiLink('');
    }
    await prefs.setInt('timesStarted', timesStarted);
  }

  _setApiLink([String link]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _prefLink = (prefs.getString('link') ?? link);

    if (_prefLink != link) {
      if ((link != null || link != '')) {
        _prefLink = link;
      }
    }
    await prefs.setString('link', _prefLink);

    setState(() {
      controller.text = _prefLink;
      exampleText = _prefLink;
    });
  }

  _getApiLink() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiLink = prefs.getString('link');

    setState(() {
      controller.text = apiLink;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text('API link'),
          TextField(
            controller: controller,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
            child: Text('http://$exampleText:5000'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                _setApiLink(controller.text);
              },
              child: Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
