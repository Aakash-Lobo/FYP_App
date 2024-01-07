import 'package:flutter/material.dart';

class AddOrderCategoryPage extends StatelessWidget {
  final String username;

  AddOrderCategoryPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Center(
        child: Text('Welcome to the Order Page, $username!'),
      ),
    );
  }
}
