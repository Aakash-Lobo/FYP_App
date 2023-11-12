import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'admin_student_index.dart';

class AddStudentPage extends StatefulWidget {
  final String username;

  AddStudentPage({required this.username});

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController prospectusIssuedController = TextEditingController();
  TextEditingController prospectusAmountController = TextEditingController();
  TextEditingController applicantStatusController = TextEditingController();
  TextEditingController applicationStatusController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();

  String? selectedCourse;
  String? selectedProspectusIssued;
  String? selectedProspectusAmount;
  String? selectedApplicantStatus;
  String? selectedApplicationStatus;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'Add Student Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: firstNameController,
                decoration:
                    InputDecoration(labelText: 'Applicant First Name:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: middleNameController,
                decoration:
                    InputDecoration(labelText: 'Applicant Middle Name:'),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Applicant Last Name:*'),
              ),
              TextFormField(
                controller: fatherNameController,
                decoration: InputDecoration(labelText: 'Father Name:*'),
              ),
              TextFormField(
                controller: rollNoController,
                decoration: InputDecoration(labelText: 'Student Roll No:'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Applicant Email:*',
                  hintText: 'example@example.com',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              buildDropdownFormField(
                labelText: 'Course which you want?:',
                options: ['Option1', 'Option2', 'Option3'],
                value: selectedCourse,
                onChanged: (value) {
                  setState(() {
                    selectedCourse = value!;
                  });
                },
              ),
              buildDropdownFormField(
                labelText: 'Prospectus Issued:',
                options: ['Yes', 'No'],
                value: selectedProspectusIssued,
                onChanged: (value) {
                  setState(() {
                    selectedProspectusIssued = value!;
                  });
                },
              ),
              buildDropdownFormField(
                labelText: 'Prospectus Amount Recvd:',
                options: ['Yes', 'No'],
                value: selectedProspectusAmount,
                onChanged: (value) {
                  setState(() {
                    selectedProspectusAmount = value!;
                  });
                },
              ),
              buildDropdownFormField(
                labelText: 'Applicant Status:',
                options: ['Admitted', 'Not Admitted'],
                value: selectedApplicantStatus,
                onChanged: (value) {
                  setState(() {
                    selectedApplicantStatus = value!;
                  });
                },
              ),
              buildDropdownFormField(
                labelText: 'Application Status:',
                options: ['Approved', 'Not Approved'],
                value: selectedApplicationStatus,
                onChanged: (value) {
                  setState(() {
                    selectedApplicationStatus = value!;
                  });
                },
              ),
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(labelText: 'Date of Birth:'),
              ),
              TextFormField(
                controller: mobileNoController,
                decoration: InputDecoration(labelText: 'Mobile No:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the mobile number';
                  }
                  return null;
                },
              ),
              buildDropdownFormField(
                labelText: 'Gender:',
                options: ['Male', 'Female'],
                value: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),
              TextFormField(
                controller: permanentAddressController,
                decoration: InputDecoration(labelText: 'Permanent Address:'),
              ),
              TextFormField(
                controller: currentAddressController,
                decoration: InputDecoration(labelText: 'Current Address:'),
              ),
              TextFormField(
                controller: placeOfBirthController,
                decoration: InputDecoration(labelText: 'Place of Birth:'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, send data to server
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownFormField({
    required String labelText,
    required List<String> options,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  void _submitForm() async {
    // Send form data to server
    final response = await http.post(
      Uri.parse(
          "http://localhost/fyp/app/admin/profile/student/addstudent.php"),
      body: {
        'first_name': firstNameController.text,
        'middle_name': middleNameController.text,
        'last_name': lastNameController.text,
        'father_name': fatherNameController.text,
        'roll_no': rollNoController.text,
        'email': emailController.text,
        'course_code': selectedCourse ?? '',
        'prospectus_issued': selectedProspectusIssued ?? '',
        'prospectus_amount': selectedProspectusAmount ?? '',
        'applicant_status': selectedApplicantStatus ?? '',
        'application_status': selectedApplicationStatus ?? '',
        'dob': dobController.text,
        'mobile_no': mobileNoController.text,
        'gender': selectedGender ?? '',
        'permanent_address': permanentAddressController.text,
        'current_address': currentAddressController.text,
        'place_of_birth': placeOfBirthController.text,
      },
    );

    if (response.statusCode == 200) {
      // Parse the response to check if the student was added successfully
      Map<String, dynamic> result = json.decode(response.body);

      if (result['message'] == 'Student added successfully') {
        // Successful submission
        print('Student added successfully');

        // Redirect to AdminStudent page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => AdminStudent(username: widget.username)),
        );
      } else {
        // Error in submission
        print('Failed to add student');
      }
    } else {
      // HTTP request failed
      print('HTTP request failed with status: ${response.statusCode}');
    }
  }
}
