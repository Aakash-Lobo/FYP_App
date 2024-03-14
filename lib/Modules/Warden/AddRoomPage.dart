import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Room {
  final int seater;
  final int roomNo;
  final int fees;

  Room({
    required this.seater,
    required this.roomNo,
    required this.fees,
  });
}

class AddRoomPage extends StatefulWidget {
  final String username;

  AddRoomPage({required this.username});

  @override
  _AddRoomPageState createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final TextEditingController roomNoController = TextEditingController();
  final TextEditingController seaterController = TextEditingController();
  final TextEditingController feeController = TextEditingController();

  Future<void> addRoom() async {
    try {
      int seater = int.parse(seaterController.text);
      int roomNo = int.parse(roomNoController.text);
      int fees = int.parse(feeController.text);

      final response = await http.post(
        Uri.parse('http://localhost/fyp/app/modules/hostel/addroom.php'),
        body: jsonEncode({
          'seater': seater,
          'roomno': roomNo,
          'fee': fees,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Room added successfully
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Room added successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Failed to add room
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to add room!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Error parsing input or HTTP request
      print('Error adding room: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the Add Room, ${widget.username}!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: roomNoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Room Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: seaterController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Seater',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: feeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total Fees',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addRoom,
              child: Text('Add Room'),
            ),
          ],
        ),
      ),
    );
  }
}
