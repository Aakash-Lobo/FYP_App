import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Librarian/BookViewPage%20.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewBooksPage extends StatefulWidget {
  final String username;

  ViewBooksPage({required this.username});

  @override
  _ViewBooksPageState createState() => _ViewBooksPageState();
}

class _ViewBooksPageState extends State<ViewBooksPage> {
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
        Uri.parse("http://localhost/fyp/app/modules/lib/viewbook.php"),
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

  Future<void> deleteBook(String bookId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost/fyp/app/modules/lib/deletebook.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'book_id': bookId}),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Book with ID $bookId deleted successfully');
      } else {
        // Error in deletion
        print(
            'Failed to delete book with ID $bookId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after deletion
      fetchData();
    } catch (error) {
      print('Error deleting book: $error');
    }
  }

  Future<void> updateBook(
      String bookId, String updatedTitle, String updatedAuthor) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/lib/updatebook.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'book_id': bookId,
          'book_title': updatedTitle,
          'author': updatedAuthor,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        if (result['status'] == 'success') {
          // Successful update
          print('Book with ID $bookId updated successfully');
        } else {
          // Error in update
          print('Failed to update book with ID $bookId. ${result['message']}');
        }
      } else {
        print(
            'Failed to update book with ID $bookId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after updating
      fetchData();
    } catch (error) {
      print('Error updating book: $error');
    }
  }

  void _showEditModal(Map<String, dynamic> book) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _authorController = TextEditingController();

    _titleController.text = book['book_title'];
    _authorController.text = book['author'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Edit Book',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Update'),
                        content:
                            Text('Are you sure you want to update this book?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Perform the update
                              updateBook(
                                book['book_id'],
                                _titleController.text,
                                _authorController.text,
                              );
                              Navigator.of(context)
                                  .pop(); // Close the confirmation dialog
                              Navigator.pop(context); // Close the bottom sheet
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToViewPage(Map<String, dynamic> book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookViewPage(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Books'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'View Books Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Book')),
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Author')),
                DataColumn(label: Text('Action')),
              ],
              rows: filteredBooks.map((book) {
                return DataRow(
                  cells: [
                    DataCell(
                      book['book_image'] != null
                          ? Image.network(
                              "http://localhost/fyp/app/modules/lib/Images/${book['book_image']}",
                              width: 50,
                              height: 50,
                            )
                          : Image.network(
                              "http://localhost/fyp/app/modules/lib/Images/book_image.jpg",
                              width: 50,
                              height: 50,
                            ),
                    ),
                    DataCell(Text(book['book_title'])),
                    DataCell(Text(book['author'])),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Book'),
                                    content: Text(
                                        'Are you sure you want to delete this book?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteBook(book['book_id']);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Delete'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              _showEditModal(book);
                            },
                            child: Text('Edit'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              _navigateToViewPage(book);
                            },
                            child: Text('View'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
