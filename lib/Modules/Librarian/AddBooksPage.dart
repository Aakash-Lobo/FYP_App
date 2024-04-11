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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Books',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DefaultTextStyle(
          style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Increase spacing between fields
                  TextFormField(
                    controller: _bookTitleController,
                    decoration: InputDecoration(
                      labelText: 'Book Title:*',
                      hintText: 'Add Title',
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
                        return 'Please enter the book title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20), // Increase spacing between fields
                  TextFormField(
                    controller: _authorController,
                    decoration: InputDecoration(
                      labelText: 'Author:*',
                      hintText: 'Add Author',
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
                        return 'Please enter the author';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _author2Controller,
                    decoration: InputDecoration(
                      labelText: 'Author 2:',
                      hintText: 'Add Author',
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
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _publicationController,
                    decoration: InputDecoration(
                      labelText: 'Publication:',
                      hintText: 'Add Publication',
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
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _publisherNameController,
                    decoration: InputDecoration(
                      labelText: 'Publisher Name:',
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
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _isbnController,
                    decoration: InputDecoration(
                      labelText: 'ISBN:*',
                      hintText: 'Add Number',
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
                        return 'Please enter the ISBN';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _copyrightYearController,
                    decoration: InputDecoration(
                      labelText: 'Copyright Year:',
                      hintText: 'Add Year',
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
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _bookCopiesController,
                    decoration: InputDecoration(
                      labelText: 'Book Copies:*',
                      hintText: 'Add Copies',
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
                        return 'Please enter the number of book copies';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20), // Increase spacing between fields
                  DropdownButtonFormField(
                    value: _selectedCategory,
                    items: _categories.map((Category category) {
                      return DropdownMenuItem(
                        value: category.classname,
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
                      hintText: 'Add Category',
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
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20), // Increase spacing between fields
                  SizedBox(
                    width: double
                        .infinity, // Set button width to match input fields
                    height: 50, // Set button height
                    child: ElevatedButton(
                      onPressed: addBook,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Set border radius to 10
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
