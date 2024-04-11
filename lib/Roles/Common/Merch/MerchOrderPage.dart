import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MerchOrderPage extends StatefulWidget {
  final String username;

  MerchOrderPage({required this.username});

  @override
  _MerchOrderPageState createState() => _MerchOrderPageState();
}

class _MerchOrderPageState extends State<MerchOrderPage> {
  List<dynamic> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final response = await http.get(Uri.parse(
        'http://localhost/fyp/app/common/merch/vieworders.php?username=${Uri.encodeComponent(widget.username)}'));

    if (response.statusCode == 200) {
      setState(() {
        orders = jsonDecode(response.body)['orders'];
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders',
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Order ID: ${orders[index]['orderId']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address: ${orders[index]['address']}'),
                  Text('Phone No: ${orders[index]['phoneNo']}'),
                  Text('Amount: ${orders[index]['amount']}'),
                  Text('Payment Mode: ${orders[index]['paymentMode']}'),
                  Text('Order Date: ${orders[index]['orderDate']}'),
                ],
              ),
              onTap: () {
                // Handle tap on order
              },
            ),
          );
        },
      ),
    );
  }
}
