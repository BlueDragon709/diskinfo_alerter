import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  String _apiLink;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _setApiLink('');
  }

  _setApiLink(String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _prefLink = (prefs.getString('link') ?? link);
    await prefs.setString('link', _prefLink);

    setState(() {
      _apiLink = _prefLink;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Processing data'),
                    ));
                  }
                },
                child: Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
