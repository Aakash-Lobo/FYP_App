import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewOrderPage extends StatefulWidget {
  final String username;

  ViewOrderPage({required this.username});

  @override
  _ViewOrderPageState createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/fyp/app/modules/cafe/vieworders.php'),
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _orders = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Failed to fetch orders');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Order'),
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Card(
            child: ListTile(
              title: Text('Order ID: ${order['orderId']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User ID: ${order['userId']}'),
                  Text('Address: ${order['address']}'),
                  Text('Phone No: ${order['phoneNo']}'),
                  Text('Amount: ${order['amount']}'),
                  Text('Payment Mode: ${order['paymentMode']}'),
                  Text('Order Date: ${order['orderDate']}'),
                  Text('Order Status: ${order['orderStatus']}'),
                ],
              ),
              onTap: () {
                // Handle onTap
              },
            ),
          );
        },
      ),
    );
  }
}
