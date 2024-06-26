import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOrderCategoryPage extends StatefulWidget {
  final String username;

  AddOrderCategoryPage({required this.username});

  @override
  _AddOrderCategoryPageState createState() => _AddOrderCategoryPageState();
}

class _AddOrderCategoryPageState extends State<AddOrderCategoryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _addCategory() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String desc = _descController.text;

      try {
        final response = await http.post(
          Uri.parse('http://localhost/fyp/app/modules/cafe/addcategory.php'),
          body: {
            'name': name,
            'desc': desc,
          },
        );
        if (response.statusCode == 200) {
          // Category added successfully, handle the response accordingly
        } else {
          print('Failed to add category');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Category',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
        centerTitle: true,
        elevation: 0, // Remove app bar shadow
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Category Name',
                    hintText: 'Add Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter category name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20), // Add spacing between fields
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: 'Category Description',
                    hintText: 'Add Description',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter category description';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20), // Add spacing between fields
              SizedBox(
                width: double.infinity,
                height: 50, // Set button height
                child: ElevatedButton(
                  onPressed: _addCategory,
                  child: Text(
                    'Add Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    primary: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
