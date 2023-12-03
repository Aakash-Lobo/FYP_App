import 'package:flutter/material.dart';

class AddPlacementCategoryPage extends StatelessWidget {
  final String username;

  AddPlacementCategoryPage({required this.username});

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
