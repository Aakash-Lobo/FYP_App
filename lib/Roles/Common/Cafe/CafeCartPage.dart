import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CafeCartPage extends StatefulWidget {
  final String username;

  CafeCartPage({required this.username});

  @override
  _CafeCartPageState createState() => _CafeCartPageState();
}

class _CafeCartPageState extends State<CafeCartPage> {
  List<Map<String, dynamic>> cartData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://localhost/fyp/app/common/cafe/viewcart.php?username=${widget.username}"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          cartData = List<Map<String, dynamic>>.from(data);
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
        title: Text('View Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display the cart items in a table
            DataTable(
              columns: [
                DataColumn(label: Text('No.')),
                DataColumn(label: Text('Product Name')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Action')),
              ],
              rows: cartData.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text('${cartData.indexOf(item) + 1}')),
                    DataCell(Text(item['productName'])),
                    DataCell(Text('${item['productPrice']}')),
                    DataCell(
                      Form(
                        child: TextFormField(
                          initialValue: '${item['itemQuantity']}',
                          onChanged: (value) {
                            // Implement logic to update quantity
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                        Text('${item['productPrice'] * item['itemQuantity']}')),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          // Implement logic to remove item
                        },
                        child: Text('Remove'),
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
