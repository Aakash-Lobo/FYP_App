import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class BorrowedBook {
  final String? bookBarcode;
  final String? borrowerName;
  final String? bookTitle;
  final String? dateBorrowed;
  final String? dueDate;
  final String? dateReturned;
  final String? status;

  BorrowedBook({
    required this.bookBarcode,
    required this.borrowerName,
    required this.bookTitle,
    required this.dateBorrowed,
    required this.dueDate,
    required this.dateReturned,
    required this.status,
  });

  factory BorrowedBook.fromJson(Map<String, dynamic> json) {
    return BorrowedBook(
      bookBarcode: json['book_barcode'],
      borrowerName: '${json['first_name']} ${json['last_name']}',
      bookTitle: json['book_title'],
      dateBorrowed: json['date_borrowed'],
      dueDate: json['due_date'],
      dateReturned: json['date_returned'],
      status: json['borrowed_status'],
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
  String? dateFrom;
  String? dateTo;

  @override
  void initState() {
    super.initState();
    fetchBorrowedBooks();
  }

  Future<void> fetchBorrowedBooks() async {
    try {
      String apiUrl =
          "http://localhost/fyp/app/modules/lib/viewborrowedbooks.php";

      if (dateFrom != null && dateTo != null) {
        apiUrl += "?dateFrom=$dateFrom&dateTo=$dateTo";
      }

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Check if data is not null before mapping
        if (data != null) {
          setState(() {
            borrowedBooks =
                data.map((book) => BorrowedBook.fromJson(book)).toList();
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
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Barcode')),
                  DataColumn(label: Text('Borrower')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Date Borrowed')),
                  DataColumn(label: Text('Due Date')),
                  DataColumn(label: Text('Date Returned')),
                  DataColumn(label: Text('Status')),
                ],
                rows: borrowedBooks.map((book) {
                  return DataRow(
                    cells: [
                      DataCell(Text(book.bookBarcode ?? 'Unknown Barcode')),
                      DataCell(Text(book.borrowerName ?? 'Unknown Borrower')),
                      DataCell(Text(book.bookTitle ?? 'Unknown Title')),
                      DataCell(
                          Text(book.dateBorrowed ?? 'Unknown Date Borrowed')),
                      DataCell(Text(book.dueDate ?? 'Unknown Due Date')),
                      DataCell(Text(book.dateReturned ?? 'Not Returned')),
                      DataCell(Text(book.status ?? 'Unknown Status')),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
