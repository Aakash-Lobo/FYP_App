import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Company {
  final String name;
  final String address;
  final String contactNo;

  Company({
    required this.name,
    required this.address,
    required this.contactNo,
  });
}

class CompanyPage extends StatefulWidget {
  final String username;

  CompanyPage({required this.username});

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  List<Company> companies = [];

  @override
  void initState() {
    super.initState();
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/student/Bottom/placement/viewcompany.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          companies = List<Company>.from(data.map((company) => Company(
                name: company['name'],
                address: company['address'],
                contactNo: company['contactNo'],
              )));
        });
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (error) {
      print('Error fetching companies: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Page'),
      ),
      body: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(companies[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Address: ${companies[index].address}'),
                Text('Contact No.: ${companies[index].contactNo}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
