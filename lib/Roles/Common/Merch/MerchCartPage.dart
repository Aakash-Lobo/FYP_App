import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MerchCartPage extends StatefulWidget {
  final String username;

  MerchCartPage({required this.username});

  @override
  _MerchCartPageState createState() => _MerchCartPageState();
}

class _MerchCartPageState extends State<MerchCartPage> {
  List<dynamic> cartItems = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    // Assuming userId is available from somewhere
    final response = await http.get(Uri.parse(
        'http://localhost/fyp/app/common/merch/viewcart.php?username=$widget.username'));

    if (response.statusCode == 200) {
      setState(() {
        cartItems = jsonDecode(response.body)['items'];
        totalPrice = jsonDecode(response.body)['totalPrice'];
      });
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart',
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart Items:',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cartItems[index]['productName']),
                    subtitle:
                        Text('Price: ${cartItems[index]['productPrice']}'),
                    trailing:
                        Text('Quantity: ${cartItems[index]['itemQuantity']}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total Price: Rs. $totalPrice',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement checkout functionality
              },
              child: Text('Go to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
