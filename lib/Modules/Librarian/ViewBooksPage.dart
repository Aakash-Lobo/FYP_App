import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Librarian/EditBookPage.dart';
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

  void navigateToEditPage(String bookId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookPage(bookId: bookId),
      ),
    ).then((value) =>
        fetchData()); // Fetch data after returning from the edit page
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
                              "http://localhost/fyp/app/admin/profile/book/Images/${book['book_image']}",
                              width: 50,
                              height: 50,
                            )
                          : Image.network(
                              "http://localhost/fyp/app/admin/profile/book/Images/book_image.jpg",
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
                              navigateToEditPage(book['book_id']);
                            },
                            child: Text('Edit'),
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
