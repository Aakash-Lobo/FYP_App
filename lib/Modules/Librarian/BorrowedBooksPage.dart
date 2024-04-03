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
        title: Text(
          'Borrowed Books',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
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
                Text('From:',
                    style: TextStyle(
                        fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
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
                ),
                SizedBox(width: 16),
                Text('To:',
                    style: TextStyle(
                        fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
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
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display Borrowed Books
            Expanded(
              child: ListView.builder(
                itemCount: borrowedBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Barcode: ${borrowedBooks[index].bookBarcode ?? 'Unknown Barcode'}',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Borrower: ${borrowedBooks[index].borrowerName ?? 'Unknown Borrower'}',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Title: ${borrowedBooks[index].bookTitle ?? 'Unknown Title'}',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Date Borrowed: ${borrowedBooks[index].dateBorrowed ?? 'Unknown Date Borrowed'}',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Due Date: ${borrowedBooks[index].dueDate ?? 'Unknown Due Date'}',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Date Returned: ${borrowedBooks[index].dateReturned ?? 'Not Returned'}',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Status: ${borrowedBooks[index].status ?? 'Unknown Status'}',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
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
