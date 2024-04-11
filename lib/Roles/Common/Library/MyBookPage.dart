import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyBookPage extends StatefulWidget {
  final String username;

  MyBookPage({required this.username});

  @override
  _MyBookPageState createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  List<Map<String, dynamic>> booksData = [];
  List<Map<String, dynamic>> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://localhost/fyp/app/common/library/viewmybook.php?username=${widget.username}"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          booksData = List<Map<String, dynamic>>.from(data);
          filteredBooks = List<Map<String, dynamic>>.from(data);
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
        title: Text(
          'View Books',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4.0,
                  child: ListTile(
                    leading: book['book_image'] != null
                        ? Image.network(
                            "http://localhost/fyp/app/modules/lib/Images/${book['book_image']}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            "http://localhost/fyp/app/modules/lib/Images/book_image.jpg",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                    title: Text(
                      book['book_title'],
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    subtitle: Text(
                      book['author'],
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
