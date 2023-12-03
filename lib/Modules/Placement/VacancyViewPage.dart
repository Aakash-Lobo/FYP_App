import 'package:flutter/material.dart';

class ViewVacancyPage extends StatelessWidget {
  final String username;

  ViewVacancyPage({required this.username});

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
