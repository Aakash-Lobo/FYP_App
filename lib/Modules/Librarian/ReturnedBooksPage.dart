import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ReturnedBook {
  final String? bookBarcode;
  final String? borrowerName;
  final String? bookTitle;
  final String? dateBorrowed;
  final String? dueDate;
  final String? dateReturned;
  final String? penalty;

  ReturnedBook({
    required this.bookBarcode,
    required this.borrowerName,
    required this.bookTitle,
    required this.dateBorrowed,
    required this.dueDate,
    required this.dateReturned,
    required this.penalty,
  });

  factory ReturnedBook.fromJson(Map<String, dynamic> json) {
    return ReturnedBook(
      bookBarcode: json['book_barcode'],
      borrowerName: '${json['firstname']} ${json['lastname']}',
      bookTitle: json['book_title'],
      dateBorrowed: json['date_borrowed'],
      dueDate: json['due_date'],
      dateReturned: json['date_returned'],
      penalty: json['book_penalty'],
    );
  }
}

class ReturnedBooksPage extends StatefulWidget {
  final String username;

  ReturnedBooksPage({required this.username});

  @override
  _ReturnedBooksPageState createState() => _ReturnedBooksPageState();
}

class _ReturnedBooksPageState extends State<ReturnedBooksPage> {
  List<ReturnedBook> returnedBooks = [];
  String? dateFrom;
  String? dateTo;

  @override
  void initState() {
    super.initState();
    fetchReturnedBooks();
  }

  Future<void> fetchReturnedBooks() async {
    try {
      String apiUrl =
          "http://localhost/fyp/app/modules/lib/viewreturnedbooks.php";

      if (dateFrom != null && dateTo != null) {
        apiUrl += "?dateFrom=$dateFrom&dateTo=$dateTo";
      }

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Check if data is not null before mapping
        if (data != null) {
          setState(() {
            returnedBooks =
                data.map((book) => ReturnedBook.fromJson(book)).toList();
          });
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during HTTP request: $e');
    }
  }

  void updateDateFilters() {
    fetchReturnedBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Returned Books',
          style: TextStyle(fontFamily: 'Raleway'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Date Filters
            Row(
              children: [
                Text('From:', style: TextStyle(fontFamily: 'Raleway')),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2101),
                    );

                    if (picked != null && picked != DateTime.now()) {
                      setState(() {
                        dateFrom = DateFormat('yyyy-MM-dd').format(picked!);
                      });
                    }

                    updateDateFilters();
                  },
                  child: Text('Select Date'),
                ),
                SizedBox(width: 16),
                Text('To:', style: TextStyle(fontFamily: 'Raleway')),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2101),
                    );

                    if (picked != null) {
                      setState(() {
                        dateTo = DateFormat('yyyy-MM-dd').format(picked!);
                      });
                    }

                    updateDateFilters();
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display Returned Books
            Expanded(
              child: ListView.builder(
                itemCount: returnedBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Barcode: ${returnedBooks[index].bookBarcode ?? 'Unknown Barcode'}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Borrower: ${returnedBooks[index].borrowerName ?? 'Unknown Borrower'}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Title: ${returnedBooks[index].bookTitle ?? 'Unknown Title'}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Date Borrowed: ${returnedBooks[index].dateBorrowed ?? 'Unknown Date Borrowed'}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Due Date: ${returnedBooks[index].dueDate ?? 'Unknown Due Date'}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Date Returned: ${returnedBooks[index].dateReturned ?? 'Not Returned'}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Penalty: ${returnedBooks[index].penalty ?? 'Unknown Penalty'}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
