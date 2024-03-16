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
        title: Text('View Menu'),
      ),
      body: ListView.builder(
        itemCount: _pizzaItems.length,
        itemBuilder: (context, index) {
          final pizzaItem = _pizzaItems[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cat. Id: ${pizzaItem['pizzaCategorieId']}'),
                Image.network(
                  'http://example.com/pizza-${pizzaItem['pizzaId']}.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${pizzaItem['pizzaName']}'),
                      Text('Description: ${pizzaItem['pizzaDesc']}'),
                      Text('Price: ${pizzaItem['pizzaPrice']}'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle edit button press
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle delete button press
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
