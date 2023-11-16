import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Librarian/librarian_home.dart';
import 'package:http/http.dart' as http;

class Category {
  final String classname;

  Category({required this.classname});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(classname: json['classname']);
  }
}

class AddBooksPage extends StatefulWidget {
  final String username;

  AddBooksPage({required this.username});

  @override
  _AddBooksPageState createState() => _AddBooksPageState();
}

class _AddBooksPageState extends State<AddBooksPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _bookTitleController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _author2Controller = TextEditingController();
  TextEditingController _publicationController = TextEditingController();
  TextEditingController _publisherNameController = TextEditingController();
  TextEditingController _isbnController = TextEditingController();
  TextEditingController _copyrightYearController = TextEditingController();
  TextEditingController _bookCopiesController = TextEditingController();
  String? _selectedCategory;

  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/lib/getcategory.php"),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _categories =
              data.map((category) => Category.fromJson(category)).toList();
          print(_categories); // Add this line for debugging
        });
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during HTTP request: $e');
    }
  }

  Future<void> addBook() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/lib/addbook.php"),
        body: {
          'bookTitle': _bookTitleController.text,
          'author': _authorController.text,
          'author2': _author2Controller.text,
          'publication': _publicationController.text,
          'publisherName': _publisherNameController.text,
          'isbn': _isbnController.text,
          'copyrightYear': _copyrightYearController.text,
          'bookCopies': _bookCopiesController.text,
          'category': _selectedCategory!,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        if (result['message'] == 'Book added successfully') {
          print('Book added successfully');

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  LibrarianHomePage(username: widget.username),
            ),
          );
        } else {
          print('Failed to add book');
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Add Books Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _bookTitleController,
                decoration: InputDecoration(labelText: 'Book Title:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the book title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _author2Controller,
                decoration: InputDecoration(labelText: 'Author 2:'),
              ),
              TextFormField(
                controller: _publicationController,
                decoration: InputDecoration(labelText: 'Publication:'),
              ),
              TextFormField(
                controller: _publisherNameController,
                decoration: InputDecoration(labelText: 'Publisher Name:'),
              ),
              TextFormField(
                controller: _isbnController,
                decoration: InputDecoration(labelText: 'ISBN:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the ISBN';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _copyrightYearController,
                decoration: InputDecoration(labelText: 'Copyright Year:'),
              ),
              TextFormField(
                controller: _bookCopiesController,
                decoration: InputDecoration(labelText: 'Book Copies:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of book copies';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _selectedCategory,
                items: _categories.map((Category category) {
                  return DropdownMenuItem(
                    value: category
                        .classname, // Use the category's classname as the value
                    child: Text(category.classname),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value as String?;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Category:*',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addBook,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
