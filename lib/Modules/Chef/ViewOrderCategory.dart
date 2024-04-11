import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Chef/AddOrderCategoryPage.dart';
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
        title: Text(
          'View Category',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Id: ${category['categoryId']}',
                  style: TextStyle(fontFamily: 'Raleway'),
                ),
                SizedBox(height: 8.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'http://localhost/fyp/app/modules/cafe/Images/pizza-' +
                        '${category['categorieId']}.jpg',
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
                        'Category Detail:',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Name: ${category['categoryName']}',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                      Text(
                        'Description: ${category['categoryDesc']}',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddOrderCategoryPage(username: widget.username),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
