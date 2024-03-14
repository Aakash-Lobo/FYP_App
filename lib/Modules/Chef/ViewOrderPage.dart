import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Order {
  final int orderId;
  final int userId;
  final String address;
  final int zipCode;
  final int phoneNo;
  final int amount;
  final String paymentMode;
  final String orderDate;
  final String orderStatus;

  Order({
    required this.orderId,
    required this.userId,
    required this.address,
    required this.zipCode,
    required this.phoneNo,
    required this.amount,
    required this.paymentMode,
    required this.orderDate,
    required this.orderStatus,
  });
}

class ViewOrderPage extends StatefulWidget {
  final String username;

  ViewOrderPage({required this.username});

  @override
  _ViewOrderPageState createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/fyp/app/modules/cafe/vieworders.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          orders = List<Order>.from(data.map((order) => Order(
                orderId: order['orderId'],
                userId: order['userId'],
                address: order['address'],
                zipCode: order['zipCode'],
                phoneNo: order['phoneNo'],
                amount: order['amount'],
                paymentMode: order['paymentMode'],
                orderDate: order['orderDate'],
                orderStatus: order['orderStatus'],
              )));
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      print('Error fetching orders: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      body: orders.isEmpty
          ? Center(child: Text('No orders available'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Order ID: ${orders[index].orderId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User ID: ${orders[index].userId}'),
                      Text('Address: ${orders[index].address}'),
                      Text('Zip Code: ${orders[index].zipCode}'),
                      Text('Phone No.: ${orders[index].phoneNo}'),
                      Text('Amount: ${orders[index].amount}'),
                      Text('Payment Mode: ${orders[index].paymentMode}'),
                      Text('Order Date: ${orders[index].orderDate}'),
                      Text('Status: ${orders[index].orderStatus}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
