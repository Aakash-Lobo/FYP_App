import 'package:flutter/material.dart';

class AddCompanyPage extends StatelessWidget {
  final String username;

  AddCompanyPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Examination Page'),
      ),
      body: Center(
        child: Text('Welcome to the Examination Page, $username!'),
      ),
    );
  }
}
