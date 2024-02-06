import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditRoomPage extends StatefulWidget {
  final int roomId;
  final String roomNo;
  final String seater;
  final String fees;

  EditRoomPage({
    required this.roomId,
    required this.roomNo,
    required this.seater,
    required this.fees,
  });

  @override
  _EditRoomPageState createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  late TextEditingController roomNoController;
  late TextEditingController seaterController;
  late TextEditingController feesController;

  @override
  void initState() {
    super.initState();
    roomNoController = TextEditingController(text: widget.roomNo);
    seaterController = TextEditingController(text: widget.seater);
    feesController = TextEditingController(text: widget.fees);
  }

  Future<void> updateRoomDetails() async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/hostel/editroom.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'roomId': widget.roomId.toString(),
          'roomNo': roomNoController.text,
          'seater': seaterController.text,
          'fees': feesController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Successful update
        print('Room details updated successfully');
        // Navigate back to ViewRoomPage
        Navigator.pop(context);
      } else {
        // Handle other status codes as needed
        print(
            'Failed to update room details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error updating room details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: roomNoController,
              decoration: InputDecoration(labelText: 'Room Number'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: seaterController,
              decoration: InputDecoration(labelText: 'Seater'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: feesController,
              decoration: InputDecoration(labelText: 'Fees Per Month'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call the method to update room details
                updateRoomDetails();
              },
              child: Text('Update Room'),
            ),
          ],
        ),
      ),
    );
  }
}
