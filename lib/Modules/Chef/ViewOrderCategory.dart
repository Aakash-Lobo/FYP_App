import 'package:flutter/material.dart';

class ViewOrderCategoryPage extends StatelessWidget {
  final String username;

  ViewOrderCategoryPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Category'),
      ),
      body: Center(
        child: Text('Welcome to the Order Page, $username!'),
      ),
    );
  }
}
