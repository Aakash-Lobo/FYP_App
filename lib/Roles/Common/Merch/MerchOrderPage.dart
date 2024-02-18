import 'package:flutter/material.dart';

class MerchOrderPage extends StatelessWidget {
  final String username;

  MerchOrderPage({required this.username});

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
