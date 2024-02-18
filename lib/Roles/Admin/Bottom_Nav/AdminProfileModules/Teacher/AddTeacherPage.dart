import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/admin_teacher_index.dart';
import 'package:http/http.dart' as http;

class AddTeacherPage extends StatefulWidget {
  final String username;

  AddTeacherPage({required this.username});

  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController teacherStatusController = TextEditingController();
  TextEditingController applicationStatusController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController otherPhoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController lastQualificationController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  String? selectedTeacherStatus;
  String? selectedApplicationStatus;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'Add Teacher Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'Teacher First Name:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: middleNameController,
                decoration: InputDecoration(labelText: 'Teacher Middle Name:'),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Teacher Last Name:*'),
              ),
              TextFormField(
                controller: fatherNameController,
                decoration: InputDecoration(labelText: 'Father Name:*'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Teacher Email:*',
                  hintText: 'example@example.com',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneNoController,
                decoration: InputDecoration(labelText: 'Mobile No:*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the mobile number';
                  }
                  return null;
                },
              ),
              buildDropdownFormField(
                labelText: 'Teacher Status:',
                options: ['Permanent', 'Contract'],
                value: selectedTeacherStatus,
                onChanged: (value) {
                  setState(() {
                    selectedTeacherStatus = value!;
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
                controller: otherPhoneController,
                decoration: InputDecoration(labelText: 'Other Phone No:'),
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
              TextFormField(
                controller: lastQualificationController,
                decoration: InputDecoration(labelText: 'Last Qualification:*'),
              ),
              TextFormField(
                controller: stateController,
                decoration: InputDecoration(labelText: 'State:*'),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a value for $labelText';
        }
        return null;
      },
    );
  }

  void _submitForm() async {
    // Send form data to the server
    final response = await http.post(
      Uri.parse(
          "http://localhost/fyp/app/admin/profile/teacher/addteacher.php"),
      body: {
        'first_name': firstNameController.text,
        'middle_name': middleNameController.text,
        'last_name': lastNameController.text,
        'father_name': fatherNameController.text,
        'email': emailController.text,
        'phone_no': phoneNoController.text,
        'teacher_status': selectedTeacherStatus ?? '',
        'application_status': selectedApplicationStatus ?? '',
        'dob': dobController.text,
        'other_phone': otherPhoneController.text,
        'gender': selectedGender ?? '',
        'permanent_address': permanentAddressController.text,
        'current_address': currentAddressController.text,
        'place_of_birth': placeOfBirthController.text,
        'last_qualification': lastQualificationController.text,
        'state': stateController.text,
      },
    );

    if (response.statusCode == 200) {
      // Parse the response to check if the teacher was added successfully
      Map<String, dynamic> result = json.decode(response.body);

      if (result['message'] == 'Teacher added successfully') {
        // Successful submission
        print('Teacher added successfully');

        // Redirect to the AdminTeacher page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => AdminTeacher(username: widget.username)),
        );
      } else {
        // Error in submission
        print('Failed to add teacher');
      }
    } else {
      // HTTP request failed
      print('HTTP request failed with status: ${response.statusCode}');
    }
  }
}
