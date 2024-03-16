import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewOrderCategoryPage extends StatefulWidget {
  final String username;

  ViewOrderCategoryPage({required this.username});

  @override
  _ViewOrderCategoryPageState createState() => _ViewOrderCategoryPageState();
}

class _ViewOrderCategoryPageState extends State<ViewOrderCategoryPage> {
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/fyp/app/modules/cafe/viewcategory.php'),
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _categories = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Failed to fetch categories');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Category'),
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Id: ${category['categoryId']}'),
                Image.network(
                  'http://example.com/${category['categoryId']}.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Text('Category Detail:'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${category['categoryName']}'),
                      Text('Description: ${category['categoryDesc']}'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
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
