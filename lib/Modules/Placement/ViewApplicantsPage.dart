import 'package:flutter/material.dart';

class PlacementApplicants extends StatelessWidget {
  final String username;

  PlacementApplicants({required this.username});

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
