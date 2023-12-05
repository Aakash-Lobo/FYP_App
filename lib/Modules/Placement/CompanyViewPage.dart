import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewCompanyPage extends StatefulWidget {
  final String username;

  ViewCompanyPage({required this.username});

  @override
  _ViewCompanyPageState createState() => _ViewCompanyPageState();
}

class _ViewCompanyPageState extends State<ViewCompanyPage> {
  List<Map<String, dynamic>> companiesData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/placement/viewcompany.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          companiesData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deleteCompany(String companyId) async {
    try {
      final response = await http.delete(
        Uri.parse(
            "http://localhost/fyp/app/modules/placement/deletecompany.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'COMPANYID': companyId}),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Company with ID $companyId deleted successfully');
      } else if (response.statusCode == 400) {
        // Bad Request
        print('Missing company_id parameter');
      } else if (response.statusCode == 500) {
        // Internal Server Error
        print('Failed to delete company. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else {
        // Handle other status codes as needed
        print('Unexpected status code: ${response.statusCode}');
      }

      // Refresh the data after deletion
      fetchData();
    } catch (error) {
      print('Error deleting company: $error');
    }
  }

  void _showUpdateModal(Map<String, dynamic> company) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _contactController = TextEditingController();

    _nameController.text = company['COMPANYNAME'];
    _contactController.text = company['COMPANYCONTACTNO'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Update Company',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _contactController,
                decoration: InputDecoration(labelText: 'Contact No.'),
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
                        content: Text(
                            'Are you sure you want to update this company?'),
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
                              updateCompany(
                                company['COMPANYID'],
                                _nameController.text,
                                _contactController.text,
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

  Future<void> updateCompany(
      String companyId, String updatedName, String updatedContact) async {
    try {
      final response = await http.post(
        Uri.parse(
            "http://localhost/fyp/app/modules/placement/updatecompany.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'COMPANYID': companyId,
          'COMPANYNAME': updatedName,
          'COMPANYCONTACTNO': updatedContact,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        if (result['status'] == 'success') {
          // Successful update
          print('Company with ID $companyId updated successfully');
        } else {
          // Error in update
          print(
              'Failed to update company with ID $companyId. ${result['message']}');
        }
      } else {
        print(
            'Failed to update company with ID $companyId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after updating
      fetchData();
    } catch (error) {
      print('Error updating company: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'View Companies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Address')),
                DataColumn(label: Text('Contact No.')),
                DataColumn(label: Text('Action')),
              ],
              rows: companiesData.map((company) {
                return DataRow(
                  cells: [
                    DataCell(Text(company['COMPANYNAME'])),
                    DataCell(Text(company['COMPANYADDRESS'])),
                    DataCell(Text(company['COMPANYCONTACTNO'])),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Show confirmation dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Company'),
                                    content: Text(
                                        'Are you sure you want to delete this company?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Perform the delete
                                          deleteCompany(company['COMPANYID']);
                                          Navigator.of(context)
                                              .pop(); // Close the confirmation dialog
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
                              _showUpdateModal(company);
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
