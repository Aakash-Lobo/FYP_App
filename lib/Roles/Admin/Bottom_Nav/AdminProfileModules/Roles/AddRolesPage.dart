import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddRolesPage extends StatelessWidget {
  final String username;

  AddRolesPage({required this.username});

  TextEditingController _roleController = TextEditingController();

  Future<void> addRole(BuildContext context, String roleName) async {
    final url =
        Uri.parse('http://localhost/fyp/app/admin/profile/role/addrole.php');
    try {
      final response = await http.post(
        url,
        body: {'roletype': roleName},
      );
      if (response.statusCode == 200) {
        // Role added successfully
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Success'),
            content: Text('Role added successfully.'),
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
        throw Exception('Failed to add role');
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
          'Add Role',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _roleController,
              decoration: InputDecoration(
                labelText: 'Role Name',
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
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String roleName = _roleController.text.trim();
                if (roleName.isNotEmpty) {
                  addRole(context, roleName); // Pass context to addRole
                } else {
                  // Show error if role name is empty
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Please enter a role name.'),
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
              child: Text(
                'Add Role',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Raleway',
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
