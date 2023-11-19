import 'package:flutter/material.dart';

class BookViewPage extends StatelessWidget {
  final Map<String, dynamic> book;

  BookViewPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Book Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Title: ${book['book_title']}'),
            Text('Author: ${book['author']}'),
            // Add other book details as needed
          ],
        ),
      ),
    );
  }
}
