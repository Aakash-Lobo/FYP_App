import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CafeOrderPage extends StatefulWidget {
  final String username;

  CafeOrderPage({required this.username});

  @override
  _CafeOrderPageState createState() => _CafeOrderPageState();
}

class _CafeOrderPageState extends State<CafeOrderPage> {
  List<Map<String, dynamic>> ordersData = [];
  List<Map<String, dynamic>> filteredOrders = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://localhost/fyp/app/common/cafe/vieworders.php?username=${widget.username}"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          ordersData = List<Map<String, dynamic>>.from(data);
          filteredOrders = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Orders'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'View Orders Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Order Id')),
                DataColumn(label: Text('Address')),
                DataColumn(label: Text('Phone No')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Payment Mode')),
                DataColumn(label: Text('Order Date')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Items')),
              ],
              rows: filteredOrders.map((order) {
                return DataRow(
                  cells: [
                    DataCell(Text(order['orderId'])),
                    DataCell(Text(order['address'])),
                    DataCell(Text(order['phoneNo'])),
                    DataCell(Text(order['amount'])),
                    DataCell(Text(order['paymentMode'])),
                    DataCell(Text(order['orderDate'])),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          // Handle status button press
                        },
                        child: Text('View Status'),
                      ),
                    ),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          // Handle items button press
                        },
                        child: Text('View Items'),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
