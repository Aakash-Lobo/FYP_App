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
        Uri.parse('http://localhost/fyp/app/modules/merch/vieworders.php'),
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
        title: Text(
          'View Order',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 4.0,
            child: ListTile(
              title: Text(
                'Order ID: ${order['orderId']}',
                style: TextStyle(fontFamily: 'Raleway'),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User ID: ${order['userId']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Address: ${order['address']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Phone No: ${order['phoneNo']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Amount: ${order['amount']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Payment Mode: ${order['paymentMode']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Order Date: ${order['orderDate']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Order Status: ${order['orderStatus']}',
                      style: TextStyle(fontFamily: 'Raleway')),
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
