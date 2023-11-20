import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Penalty {
  final int penaltyId;
  int penaltyAmount;

  Penalty({
    required this.penaltyId,
    required this.penaltyAmount,
  });

  factory Penalty.fromJson(Map<String, dynamic> json) {
    return Penalty(
      penaltyId: int.parse(json['penalty_id'].toString()),
      penaltyAmount: int.parse(json['penalty_amount'].toString()),
    );
  }
}

class AllowedDays {
  final int allowedDaysId;
  int noOfDays;

  AllowedDays({
    required this.allowedDaysId,
    required this.noOfDays,
  });

  factory AllowedDays.fromJson(Map<String, dynamic> json) {
    return AllowedDays(
      allowedDaysId: int.parse(json['allowed_days_id'].toString()),
      noOfDays: int.parse(json['no_of_days'].toString()),
    );
  }
}

class AllowedBooks {
  final int allowedBooksId;
  int qnttyBooks;

  AllowedBooks({
    required this.allowedBooksId,
    required this.qnttyBooks,
  });

  factory AllowedBooks.fromJson(Map<String, dynamic> json) {
    return AllowedBooks(
      allowedBooksId: json['allowed_books_id'] ?? 0,
      qnttyBooks: int.tryParse(json['qntty_books'].toString()) ?? 0,
    );
  }
}

class LibrarianSettingsPage extends StatefulWidget {
  final String username;

  LibrarianSettingsPage({required this.username});

  @override
  _LibrarianSettingsPageState createState() => _LibrarianSettingsPageState();
}

class _LibrarianSettingsPageState extends State<LibrarianSettingsPage> {
  late List<Penalty> penalties = [];
  late List<AllowedDays> allowedDays = [];
  late List<AllowedBooks> allowedBooks = []; // Initialize with an empty list

  TextEditingController penaltyController = TextEditingController();
  TextEditingController allowedDaysController = TextEditingController();
  TextEditingController allowedBooksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchPenalties();
    await fetchAllowedDays();
    await fetchAllowedBooks();
  }

  Future<void> fetchAllowedDays() async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost/fyp/app/modules/lib/allowed_days.php'));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final List<dynamic> allowedDaysData = data['data'];
        setState(() {
          allowedDays = allowedDaysData
              .map((allowedDays) => AllowedDays.fromJson(allowedDays))
              .toList();
        });
      } else {
        print(
            'Failed to load allowed days. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching allowed days: $error');
    }
  }

  Future<void> fetchAllowedBooks() async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost/fyp/app/modules/lib/allowed_books.php'));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final List<dynamic> allowedBooksData = data['data'];
        setState(() {
          allowedBooks = allowedBooksData
              .map((allowedBooks) => AllowedBooks.fromJson(allowedBooks))
              .toList();
        });
      } else {
        print(
            'Failed to load allowed books. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching allowed books: $error');
    }
  }

  Future<void> fetchPenalties() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost/fyp/app/modules/lib/penalties.php'));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final List<dynamic> penaltiesData = data['data'];
        setState(() {
          penalties = penaltiesData
              .map((penalty) => Penalty.fromJson(penalty))
              .toList();
        });
      } else {
        print('Failed to load penalties. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching penalties: $error');
    }
  }

  Future<void> updatePenalty(int index) async {
    final response = await http.post(
      Uri.parse('http://localhost/fyp/app/modules/lib/update_penalty.php'),
      body: {
        'penalty_id': penalties[index].penaltyId.toString(),
        'penalty_amount': penaltyController.text,
      },
    );

    if (response.statusCode == 200) {
      fetchPenalties();
      Navigator.of(context).pop(); // Close the bottom modal sheet
    } else {
      print('Failed to update penalty. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateAllowedDays(int index) async {
    final response = await http.post(
      Uri.parse('http://localhost/fyp/app/modules/lib/update_allowed_days.php'),
      body: {
        'allowed_days_id': allowedDays[index].allowedDaysId.toString(),
        'no_of_days': allowedDaysController.text,
      },
    );

    if (response.statusCode == 200) {
      fetchAllowedDays();
      Navigator.of(context).pop(); // Close the bottom modal sheet
    } else {
      print(
          'Failed to update allowed days. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateAllowedBooks(int index) async {
    final response = await http.post(
      Uri.parse(
          'http://localhost/fyp/app/modules/lib/update_allowed_books.php'),
      body: {
        'allowed_books_id': allowedBooks[index].allowedBooksId.toString(),
        'qntty_books': allowedBooksController.text,
      },
    );

    if (response.statusCode == 200) {
      fetchAllowedBooks();
      Navigator.of(context).pop(); // Close the bottom modal sheet
    } else {
      print(
          'Failed to update allowed books. Status code: ${response.statusCode}');
    }
  }

  void _showEditModal(BuildContext context, String fieldType, int index) {
    TextEditingController controller;

    switch (fieldType) {
      case 'Penalty':
        controller = penaltyController;
        break;
      case 'Allowed Days':
        controller = allowedDaysController;
        break;
      case 'Allowed Books':
        controller = allowedBooksController;
        break;
      default:
        controller = TextEditingController(); // Default controller
        break;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit $fieldType',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter new value'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  switch (fieldType) {
                    case 'Penalty':
                      updatePenalty(index);
                      break;
                    case 'Allowed Days':
                      updateAllowedDays(index);
                      break;
                    case 'Allowed Books':
                      updateAllowedBooks(index);
                      break;
                    default:
                      break;
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            buildSectionTitle('Penalty'),
            buildPenaltyTable(),
            SizedBox(height: 20),
            buildSectionTitle('Allowed Days'),
            buildAllowedDaysTable(),
            SizedBox(height: 20),
            buildSectionTitle('Allowed Books'),
            buildAllowedBooksTable(),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget buildPenaltyTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Actions')),
      ],
      rows: penalties.asMap().entries.map((entry) {
        final index = entry.key;
        final Penalty penalty = entry.value;
        return DataRow(
          cells: [
            DataCell(Text(penalty.penaltyAmount.toString())),
            DataCell(
              ElevatedButton(
                onPressed: () {
                  penaltyController.text = penalty.penaltyAmount.toString();
                  _showEditModal(context, 'Penalty', index);
                },
                child: Text('Edit'),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildAllowedDaysTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Number of Days')),
        DataColumn(label: Text('Actions')),
      ],
      rows: allowedDays.asMap().entries.map((entry) {
        final index = entry.key;
        final AllowedDays days = entry.value;
        return DataRow(
          cells: [
            DataCell(Text(days.noOfDays.toString())),
            DataCell(
              ElevatedButton(
                onPressed: () {
                  allowedDaysController.text = days.noOfDays.toString();
                  _showEditModal(context, 'Allowed Days', index);
                },
                child: Text('Edit'),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildAllowedBooksTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Actions')),
      ],
      rows: allowedBooks.asMap().entries.map((entry) {
        final index = entry.key;
        final AllowedBooks books = entry.value;
        return DataRow(
          cells: [
            DataCell(Text(books.qnttyBooks.toString())),
            DataCell(
              ElevatedButton(
                onPressed: () {
                  allowedBooksController.text = books.qnttyBooks.toString();
                  _showEditModal(context, 'Allowed Books', index);
                },
                child: Text('Edit'),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
