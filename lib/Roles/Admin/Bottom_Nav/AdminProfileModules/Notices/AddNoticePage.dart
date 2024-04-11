import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNoticePage extends StatefulWidget {
  final String username;

  AddNoticePage({required this.username});

  @override
  _AddNoticePageState createState() => _AddNoticePageState();
}

class _AddNoticePageState extends State<AddNoticePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  Future<void> addNotice(String title, String message) async {
    final url = Uri.parse(
        'http://localhost/fyp/app/admin/profile/notice/addnotice.php');
    try {
      final response = await http.post(
        url,
        body: {
          'title': title,
          'message': message,
        },
      );
      if (response.statusCode == 200) {
        // Notice added successfully
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Success'),
            content: Text('Notice added successfully.'),
            actions: [
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
        throw Exception('Failed to add notice');
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
          'Add Notice',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ), // Bold text
          textAlign: TextAlign.center, // Centered text
        ),
        centerTitle: true, // Center app bar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              labelText: 'Title',
              controller: _titleController,
            ),
            SizedBox(height: 16.0),
            InputField(
              labelText: 'Message',
              controller: _messageController,
              maxLines: 5,
            ),
            SizedBox(height: 16.0),
            FormButton(
              text: 'Add Notice',
              onPressed: () {
                String title = _titleController.text.trim();
                String message = _messageController.text.trim();
                if (title.isNotEmpty && message.isNotEmpty) {
                  addNotice(title, message);
                } else {
                  // Show error if title or message is empty
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Please enter both title and message.'),
                      actions: [
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
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final int? maxLines;

  const InputField({
    required this.labelText,
    this.controller,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        labelText: labelText,
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
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FormButton({
    required this.text,
    required this.onPressed,
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
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
    );
  }
}
