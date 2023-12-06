import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewVacancyPage extends StatefulWidget {
  final String username;

  ViewVacancyPage({required this.username});

  @override
  _ViewVacancyPageState createState() => _ViewVacancyPageState();
}

class _ViewVacancyPageState extends State<ViewVacancyPage> {
  List<Map<String, dynamic>> jobsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/placement/viewjob.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          jobsData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deleteJob(String jobId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost/fyp/app/modules/placement/deletejob.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'job_id': jobId}),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Job with ID $jobId deleted successfully');
      } else {
        // Error in deletion
        print(
            'Failed to delete job with ID $jobId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after deletion
      fetchData();
    } catch (error) {
      print('Error deleting job: $error');
    }
  }

  Future<void> updateJob(
      String jobId, Map<String, dynamic> updatedJobData) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/placement/updatejob.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'job_id': jobId, ...updatedJobData}),
      );

      if (response.statusCode == 200) {
        print('Job with ID $jobId updated successfully');
      } else {
        print(
            'Failed to update job with ID $jobId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after updating
      fetchData();
    } catch (error) {
      print('Error updating job: $error');
    }
  }

  void _showUpdateModal(BuildContext context, Map<String, dynamic> job) {
    TextEditingController _occupationController = TextEditingController();

    _occupationController.text = job['OCCUPATIONTITLE'];

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
                'Update Job',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _occupationController,
                decoration: InputDecoration(labelText: 'Occupation Title'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Update'),
                        content:
                            Text('Are you sure you want to update this job?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              updateJob(
                                job['JOBID'],
                                {'OCCUPATIONTITLE': _occupationController.text},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Vacancies'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'View Job Vacancies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Company Name')),
                DataColumn(label: Text('Occupation Title')),
                DataColumn(label: Text('Required Employees')),
                DataColumn(label: Text('Salaries')),
                DataColumn(label: Text('Duration of Employment')),
                DataColumn(label: Text('Qualification/Experience')),
                DataColumn(label: Text('Job Description')),
                DataColumn(label: Text('Preferred Sex')),
                DataColumn(label: Text('Sector of Vacancy')),
                DataColumn(label: Text('Action')),
              ],
              rows: jobsData.map((job) {
                return DataRow(
                  cells: [
                    DataCell(Text(job['COMPANYNAME'])),
                    DataCell(Text(job['OCCUPATIONTITLE'])),
                    DataCell(Text(job['REQ_NO_EMPLOYEES'])),
                    DataCell(Text(job['SALARIES'])),
                    DataCell(Text(job['DURATION_EMPLOYEMENT'])),
                    DataCell(Text(job['QUALIFICATION_WORKEXPERIENCE'])),
                    DataCell(Text(job['JOBDESCRIPTION'])),
                    DataCell(Text(job['PREFEREDSEX'])),
                    DataCell(Text(job['SECTOR_VACANCY'])),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Job'),
                                    content: Text(
                                        'Are you sure you want to delete this job?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteJob(job['JOBID']);
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
                              _showUpdateModal(context, job);
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
