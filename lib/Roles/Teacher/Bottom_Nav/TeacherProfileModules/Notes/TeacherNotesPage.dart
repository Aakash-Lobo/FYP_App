import 'package:flutter/material.dart';

class TeacherNotesPage extends StatelessWidget {
  final String username;

  TeacherNotesPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counselling Page',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: TeacherNotesForm(),
      ),
    );
  }
}

class TeacherNotesForm extends StatefulWidget {
  @override
  _TeacherNotesFormState createState() => _TeacherNotesFormState();
}

class _TeacherNotesFormState extends State<TeacherNotesForm> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedCourse;
  late String _selectedSubject;
  late String _notesName;
  late String _filePath = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select Course:',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 16.0,
            ),
          ),
          TextFormField(
            // Replace this with dropdown to select course
            decoration: InputDecoration(
              hintText: 'Course',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a course';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          Text(
            'Select Subject:',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 16.0,
            ),
          ),
          TextFormField(
            // Replace this with dropdown to select subject
            decoration: InputDecoration(
              hintText: 'Subject',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a subject';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          Text(
            'Notes Name:',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 16.0,
            ),
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _notesName = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter notes name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter notes name';
              }
              return null;
            },
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  _filePath.isEmpty ? 'No file selected' : _filePath,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16.0,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // Add file picker logic here
                  // For demonstration, set a dummy file path
                  setState(() {
                    _filePath = '/path/to/selected/file';
                  });
                },
                icon: Icon(Icons.attach_file),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process form data
                  // For demonstration, print the selected data
                  print('Course: $_selectedCourse');
                  print('Subject: $_selectedSubject');
                  print('Notes Name: $_notesName');
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
