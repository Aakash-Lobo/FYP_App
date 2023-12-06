import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category {
  final String category;

  Category({required this.category});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(category: json['category']);
  }
}

class AddPlacementCategoryPage extends StatefulWidget {
  final String username;

  AddPlacementCategoryPage({required this.username});

  @override
  _AddPlacementCategoryPageState createState() =>
      _AddPlacementCategoryPageState();
}

class _AddPlacementCategoryPageState extends State<AddPlacementCategoryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _categoryController = TextEditingController();

  Future<void> addCategory() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/placement/addcategory.php"),
        body: {
          'CATEGORY': _categoryController.text,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        if (result['message'] == 'Category added successfully') {
          print('Category added successfully');
          // Handle successful addition, e.g., navigate to another page
        } else {
          print('Failed to add category');
          // Handle failure, e.g., show an error message
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
        // Handle HTTP request failure, e.g., show an error message
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addCategory,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
