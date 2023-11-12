import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final String username;

  SettingsPage({required this.username});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add settings content here
            Text('Settings Page for ${widget.username}'),
          ],
        ),
      ),
    );
  }
}
