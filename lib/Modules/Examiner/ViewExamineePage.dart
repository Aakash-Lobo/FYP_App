import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewExamineePage extends StatefulWidget {
  final String username;

  ViewExamineePage({required this.username});

  @override
  _ViewExamineePageState createState() => _ViewExamineePageState();
}

class _ViewExamineePageState extends State<ViewExamineePage> {
  List<Map<String, dynamic>> examineesData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/exam/viewexaminee.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          examineesData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deleteExaminee(String exmneId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost/fyp/app/modules/exam/deleteexaminee.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'exmne_id': exmneId}),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Examinee with ID $exmneId deleted successfully');
      } else {
        // Error in deletion
        print(
            'Failed to delete examinee with ID $exmneId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after deletion
      fetchData();
    } catch (error) {
      print('Error deleting examinee: $error');
    }
  }

  void _showUpdateModal(BuildContext context, Map<String, dynamic> examinee) {
    TextEditingController _fullnameController = TextEditingController();
    TextEditingController _genderController = TextEditingController();
    TextEditingController _birthdateController = TextEditingController();
    TextEditingController _subjectController = TextEditingController();
    TextEditingController _yearController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _statusController = TextEditingController();

    _fullnameController.text = examinee['first_name'] ?? '';
    _genderController.text = examinee['gender'] ?? '';
    _birthdateController.text = examinee['dob'] ?? '';
    _subjectController.text = examinee['course_code'] ?? '';
    _yearController.text = examinee['semester'] ?? '';
    _emailController.text = examinee['email'] ?? '';

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Update Examinee',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _fullnameController,
                decoration: InputDecoration(labelText: 'Fullname'),
              ),
              TextField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: _birthdateController,
                decoration: InputDecoration(labelText: 'Birthdate'),
              ),
              TextField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
              ),
              TextField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Update'),
                        content: Text(
                            'Are you sure you want to update this examinee?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              updateExaminee(
                                examinee['exmne_id'],
                                {
                                  'first_name': _fullnameController.text,
                                  'gender': _genderController.text,
                                  'dob': _birthdateController.text,
                                  'course_code': _subjectController.text,
                                  'semester': _yearController.text,
                                  'email': _emailController.text,
                                },
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
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

  Future<void> updateExaminee(
      String exmneId, Map<String, dynamic> updatedExamineeData) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/exam/updateexaminee.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'exmne_id': exmneId, ...updatedExamineeData}),
      );

      if (response.statusCode == 200) {
        print('Examinee with ID $exmneId updated successfully');
      } else {
        print(
            'Failed to update examinee with ID $exmneId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after updating
      fetchData();
    } catch (error) {
      print('Error updating examinee: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Examinee Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'View Examinee Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Fullname')),
                DataColumn(label: Text('Gender')),
                DataColumn(label: Text('DOB')),
                DataColumn(label: Text('Subject')),
                DataColumn(label: Text('Year')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Action')),
              ],
              rows: examineesData.map((examinee) {
                return DataRow(
                  cells: [
                    DataCell(Text(examinee['first_name'] ?? '')),
                    DataCell(Text(examinee['gender'] ?? '')),
                    DataCell(Text(examinee['dob'] ?? '')),
                    DataCell(Text(examinee['course_code'] ?? '')),
                    DataCell(Text(examinee['semester'] ?? '')),
                    DataCell(Text(examinee['email'] ?? '')),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Examinee'),
                                    content: Text(
                                        'Are you sure you want to delete this examinee?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteExaminee(examinee['exmne_id']);
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
                              _showUpdateModal(context, examinee);
                            },
                            child: Text('Update'),
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
