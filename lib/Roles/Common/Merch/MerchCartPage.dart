import 'package:flutter/material.dart';

class MerchCartPage extends StatelessWidget {
  final String username;

  MerchCartPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applied Page'),
      ),
      body: Center(
        child: Text('Welcome to the Applied Page, $username!'),
      ),
    );
  }
}
