import 'package:flutter/material.dart';

class ViewOrderPage extends StatelessWidget {
  final String username;

  ViewOrderPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      body: Center(
        child: Text('Welcome to the Order Page, $username!'),
      ),
    );
  }
}
