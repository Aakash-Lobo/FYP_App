import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddMenuPage extends StatefulWidget {
  final String username;

  AddMenuPage({required this.username});

  @override
  _AddMenuPageState createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _categoryId = '';

  Future<void> _addPizza() async {
    final String name = _nameController.text;
    final String description = _descriptionController.text;
    final String price = _priceController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost/fyp/app/modules/cafe/addmenu.php'),
        body: {
          'name': name,
          'description': description,
          'price': price,
          'categoryId': _categoryId,
        },
      );
      if (response.statusCode == 200) {
        // Pizza added successfully, handle the response accordingly
      } else {
        print('Failed to add pizza');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pizza'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the price';
                }
                return null;
              },
            ),
            // DropdownButtonFormField<String>(
            //   value: _categoryId,
            //   items: [
            //     DropdownMenuItem(
            //       value: '1',
            //       child: Text('Category 1'),
            //     ),
            //     DropdownMenuItem(
            //       value: '2',
            //       child: Text('Category 2'),
            //     ),
            //     // Add more DropdownMenuItems for other categories
            //   ],
            //   onChanged: (value) {
            //     setState(() {
            //       _categoryId = value!;
            //     });
            //   },
            //   decoration: InputDecoration(labelText: 'Category'),
            // ),
            ElevatedButton(
              onPressed: _addPizza,
              child: Text('Add Pizza'),
            ),
          ],
        ),
      ),
    );
  }
}
