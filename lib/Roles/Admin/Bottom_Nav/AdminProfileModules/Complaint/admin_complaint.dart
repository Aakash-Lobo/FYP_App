import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminComplaint extends StatefulWidget {
  final String username;

  AdminComplaint({required this.username});

  @override
  _AdminComplaintState createState() => _AdminComplaintState();
}

class _AdminComplaintState extends State<AdminComplaint> {
  List<dynamic> complaintsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://localhost/fyp/app/admin/profile/complaint/viewcomplaint.php');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as List<dynamic>;
        setState(() {
          complaintsData = responseData;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaint Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
        centerTitle: true,
      ),
      body: complaintsData.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: complaintsData.length,
              itemBuilder: (context, index) {
                final complaint = complaintsData[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                        'Complaint Number: ${complaint['complaintNumber']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User ID: ${complaint['userId']}'),
                        Text('Category: ${complaint['category']}'),
                        Text('Subcategory: ${complaint['subcategory']}'),
                        Text('Complaint Type: ${complaint['complaintType']}'),
                        Text('State: ${complaint['state']}'),
                        Text('NOC: ${complaint['noc']}'),
                        Text(
                            'Complaint Details: ${complaint['complaintDetails']}'),
                        Text('Complaint File: ${complaint['complaintFile']}'),
                        Text('Registration Date: ${complaint['regDate']}'),
                        Text('Status: ${complaint['status']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Add edit functionality
                            // You can navigate to another page for editing
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Add delete functionality
                            // You can prompt a confirmation dialog before deleting
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
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
