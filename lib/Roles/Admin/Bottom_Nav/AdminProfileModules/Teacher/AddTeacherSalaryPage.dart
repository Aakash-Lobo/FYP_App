import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTeacherSalaryPage extends StatefulWidget {
  final String username;

  AddTeacherSalaryPage({required this.username});

  @override
  _AddTeacherSalaryPageState createState() => _AddTeacherSalaryPageState();
}

class _AddTeacherSalaryPageState extends State<AddTeacherSalaryPage> {
  final TextEditingController _teacherIdController = TextEditingController();

  Future<void> _submitForm() async {
    final String teacherId = _teacherIdController.text;

    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost/fyp/app/admin/profile/teacher/addsalary.php'),
        body: {
          'teacher_id': teacherId,
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle network error
      print('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Salary',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            TextField(
              controller: _teacherIdController,
              decoration: InputDecoration(
                labelText: 'Enter Teacher ID',
                labelStyle: TextStyle(fontFamily: 'Raleway'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.blue, // Focused border color
                    width: 2.0, // Focused border width
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            FormButton(
              text: 'Save Data',
              onPressed: _submitForm,
            ),
            SizedBox(height: 20.0),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.5, // Set a height for the view
              child: ViewSalaryPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewSalaryPage extends StatefulWidget {
  @override
  _ViewSalaryPageState createState() => _ViewSalaryPageState();
}

class _ViewSalaryPageState extends State<ViewSalaryPage> {
  List<Map<String, dynamic>> _salaryData = [];

  Future<void> _fetchSalaryData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/admin/profile/teacher/viewsalary.php'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _salaryData = responseData.cast<Map<String, dynamic>>();
        });
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle network error
      print('Network error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSalaryData();
  }

  @override
  Widget build(BuildContext context) {
    return _salaryData.isNotEmpty
        ? ListView.builder(
            itemCount: _salaryData.length,
            itemBuilder: (context, index) {
              final salary = _salaryData[index];
              return ListTile(
                title: Text('Salary ID: ${salary['salary_id']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Teacher ID: ${salary['teacher_id']}'),
                    Text(
                        'Name: ${salary['first_name']} ${salary['middle_name']} ${salary['last_name']}'),
                    Text('Basic Salary: ${salary['basic_salary']}'),
                    Text('Medical Allowance: ${salary['medical_allowance']}'),
                    Text('HR Allowance: ${salary['hr_allowance']}'),
                    Text('Scale: ${salary['scale']}'),
                    Text('Paid Date: ${salary['paid_date']}'),
                    Text('Total Amount: ${salary['total_amount']}'),
                  ],
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final InputDecoration? decoration;

  const InputField({
    required this.labelText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.autoFocus = false,
    this.onChanged,
    this.onSubmitted,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black, // Border color
            width: 2.0, // Border width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue, // Focused border color
            width: 2.0, // Focused border width
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red, // Error border color
            width: 2.0, // Error border width
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red, // Focused error border color
            width: 2.0, // Focused error border width
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle style;

  const FormButton({
    required this.text,
    required this.onPressed,
    this.style = const ButtonStyle(),
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        primary: Colors.blue, // Button background color
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Raleway',
        ),
      ).merge(style), // Merge with provided style
      child: Text(
        text,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
    );
  }
}
