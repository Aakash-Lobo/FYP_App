import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewMenuPage extends StatefulWidget {
  final String username;

  ViewMenuPage({required this.username});

  @override
  _ViewMenuPageState createState() => _ViewMenuPageState();
}

class _ViewMenuPageState extends State<ViewMenuPage> {
  List<Map<String, dynamic>> _pizzaItems = [];

  @override
  void initState() {
    super.initState();
    _fetchPizzaItems();
  }

  Future<void> _fetchPizzaItems() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/fyp/app/modules/cafe/viewmenu.php'),
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _pizzaItems = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Failed to fetch pizza items');
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
          'View Menu',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _pizzaItems.length,
        itemBuilder: (context, index) {
          final pizzaItem = _pizzaItems[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cat. Id: ${pizzaItem['productCategorieId']}',
                  style: TextStyle(fontFamily: 'Raleway'),
                ),
                SizedBox(height: 8.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'http://localhost/fyp/app/modules/cafe/Images/pizza-' +
                        '${pizzaItem['productCategorieId']}.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${pizzaItem['productName']}',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                      Text(
                        'Description: ${pizzaItem['productDesc']}',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                      Text(
                        'Price: ${pizzaItem['productPrice']}',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                ),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle edit button press
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle delete button press
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
