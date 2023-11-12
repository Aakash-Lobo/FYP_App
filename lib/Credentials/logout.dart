import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final Function(bool) onLogout;

  LogoutDialog({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Logout'),
      content: Text('Are you sure you want to log out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onLogout(false); // User clicked "No"
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onLogout(true); // User clicked "Yes"
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
