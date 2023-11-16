// EditBookPage.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditBookPage extends StatefulWidget {
  final String bookId;

  EditBookPage({required this.bookId});

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController author2Controller = TextEditingController();
  TextEditingController publicationController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController isbnController = TextEditingController();
  TextEditingController copyrightController = TextEditingController();
  TextEditingController copiesController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  Map<String, dynamic>? bookData;

  @override
  void initState() {
    super.initState();
    fetchBookData();
  }

  Future<void> fetchBookData() async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://localhost/fyp/app/admin/profile/book/getbook.php?book_id=${widget.bookId}",
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          bookData = json.decode(response.body);
          initializeControllers();
        });
      } else {
        throw Exception('Failed to load book data');
      }
    } catch (error) {
      print('Error fetching book data: $error');
    }
  }

  void initializeControllers() {
    titleController.text = bookData!['book_title'];
    authorController.text = bookData!['author'];
    author2Controller.text = bookData!['author_2'];
    publicationController.text = bookData!['book_pub'];
    publisherController.text = bookData!['publisher_name'];
    isbnController.text = bookData!['isbn'];
    copyrightController.text = bookData!['copyright_year'];
    copiesController.text = bookData!['book_copies'];
    categoryController.text = bookData!['category_id'];
    // Initialize other controllers and fields here
  }

  Future<void> updateBook() async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/lib/updatebook.php"),
        body: {
          'book_id': widget.bookId,
          'book_title': titleController.text,
          'author': authorController.text,
          'author_2': author2Controller.text,
          'book_pub': publicationController.text,
          'publisher_name': publisherController.text,
          'isbn': isbnController.text,
          'copyright_year': copyrightController.text,
          'book_copies': copiesController.text,
          'category_id': categoryController.text,
          // Include other fields
        },
      );

      if (response.statusCode == 200) {
        // Handle success, maybe show a success message
        print('Book updated successfully');
        // You can also navigate back to the previous screen or perform other actions
      } else {
        // Handle error, maybe show an error message
        print('Failed to update book: ${response.body}');
        // You can show an error message to the user
      }
    } catch (error) {
      print('Error updating book: $error');
      // You can show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: bookData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Book ID: ${bookData!['book_id']}'),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  TextFormField(
                    controller: authorController,
                    decoration: InputDecoration(
                      labelText: 'Author',
                    ),
                  ),
                  TextFormField(
                    controller: author2Controller,
                    decoration: InputDecoration(
                      labelText: 'Author 2',
                    ),
                  ),
                  TextFormField(
                    controller: publicationController,
                    decoration: InputDecoration(
                      labelText: 'Publication',
                    ),
                  ),
                  TextFormField(
                    controller: publisherController,
                    decoration: InputDecoration(
                      labelText: 'Publisher',
                    ),
                  ),
                  TextFormField(
                    controller: isbnController,
                    decoration: InputDecoration(
                      labelText: 'ISBN',
                    ),
                  ),
                  TextFormField(
                    controller: copyrightController,
                    decoration: InputDecoration(
                      labelText: 'Copyright Year',
                    ),
                  ),
                  TextFormField(
                    controller: copiesController,
                    decoration: InputDecoration(
                      labelText: 'Copies',
                    ),
                  ),
                  TextFormField(
                    controller: categoryController,
                    decoration: InputDecoration(
                      labelText: 'Category ID',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updateBook();
                    },
                    child: Text('Update Book'),
                  ),
                ],
              ),
            ),
    );
  }
}
