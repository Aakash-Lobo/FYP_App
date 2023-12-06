import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCompanyPage extends StatefulWidget {
  final String username;

  AddCompanyPage({required this.username});

  @override
  _AddCompanyPageState createState() => _AddCompanyPageState();
}

class _AddCompanyPageState extends State<AddCompanyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _companyAddressController = TextEditingController();
  TextEditingController _companyContactNoController = TextEditingController();

  Future<void> addCompany() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/placement/addcompany.php"),
        body: {
          'COMPANYNAME': _companyNameController.text,
          'COMPANYADDRESS': _companyAddressController.text,
          'COMPANYCONTACTNO': _companyContactNoController.text,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        if (result['message'] == 'Company added successfully') {
          print('Company added successfully');
          // Handle navigation or any other action upon success
        } else {
          print('Failed to add company');
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Company'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Add Company Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _companyNameController,
                decoration: InputDecoration(labelText: 'Company Name:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the company name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _companyAddressController,
                decoration: InputDecoration(labelText: 'Company Address:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the company address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _companyContactNoController,
                decoration: InputDecoration(labelText: 'Company Contact No:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the company contact number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addCompany,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
