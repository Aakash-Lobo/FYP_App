import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class BorrowedBook {
  final String bookBarcode;
  final String borrowerName;
  final String bookTitle;
  final String dateBorrowed;
  final String dueDate;

  BorrowedBook({
    required this.bookBarcode,
    required this.borrowerName,
    required this.bookTitle,
    required this.dateBorrowed,
    required this.dueDate,
  });

  factory BorrowedBook.fromJson(Map<String, dynamic> json) {
    return BorrowedBook(
      bookBarcode: json['book_barcode'],
      borrowerName: '${json['first_name']} ${json['last_name']}',
      bookTitle: json['book_title'],
      dateBorrowed: DateFormat("M d, y h:m:s a")
          .format(DateTime.parse(json['date_borrowed'])),
      dueDate:
          DateFormat("M d, y h:m:s a").format(DateTime.parse(json['due_date'])),
    );
  }
}

class BorrowedBooksPage extends StatefulWidget {
  final String username;

  BorrowedBooksPage({required this.username});

  @override
  _BorrowedBooksPageState createState() => _BorrowedBooksPageState();
}

class _BorrowedBooksPageState extends State<BorrowedBooksPage> {
  List<BorrowedBook> borrowedBooks = [];
  String dateFrom = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dateTo = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    fetchBorrowedBooks();
  }

  Future<void> fetchBorrowedBooks() async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://localhost/fyp/app/modules/lib/viewborrowedbooks.php?dateFrom=$dateFrom&dateTo=$dateTo",
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          borrowedBooks =
              data.map((book) => BorrowedBook.fromJson(book)).toList();
        });
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during HTTP request: $e');
    }
  }

  // Function to update date filters
  void updateDateFilters() {
    fetchBorrowedBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowed Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Borrowed Books Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Date Filters
            Row(
              children: [
                Text('From:'),
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
                Text('To:'),
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
            // Display Borrowed Books
            Expanded(
              child: ListView.builder(
                itemCount: borrowedBooks.length,
                itemBuilder: (context, index) {
                  BorrowedBook book = borrowedBooks[index];
                  return Card(
                    child: ListTile(
                      title: Text(book.bookTitle),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Barcode: ${book.bookBarcode}'),
                          Text('Borrower: ${book.borrowerName}'),
                          Text('Date Borrowed: ${book.dateBorrowed}'),
                          Text('Due Date: ${book.dueDate}'),
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
