import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewPlacementCategoryPage extends StatefulWidget {
  final String username;

  ViewPlacementCategoryPage({required this.username});

  @override
  _ViewPlacementCategoryPageState createState() =>
      _ViewPlacementCategoryPageState();
}

class _ViewPlacementCategoryPageState extends State<ViewPlacementCategoryPage> {
  List<Map<String, dynamic>> categoriesData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://localhost/fyp/app/modules/placement/viewcategory.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          categoriesData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      final response = await http.delete(
        Uri.parse(
            "http://localhost/fyp/app/modules/placement/deletecategory.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'CATEGORYID': categoryId}),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Category with ID $categoryId deleted successfully');
      } else if (response.statusCode == 400) {
        // Bad Request
        print('Missing category_id parameter');
      } else if (response.statusCode == 500) {
        // Internal Server Error
        print('Failed to delete category. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else {
        // Handle other status codes as needed
        print('Unexpected status code: ${response.statusCode}');
      }

      // Refresh the data after deletion
      fetchData();
    } catch (error) {
      print('Error deleting category: $error');
    }
  }

  void _showUpdateModal(Map<String, dynamic> category) {
    TextEditingController _categoryController = TextEditingController();

    _categoryController.text = category['CATEGORY'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Update Category',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Update'),
                        content: Text(
                            'Are you sure you want to update this category?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Perform the update
                              updateCategory(
                                category['CATEGORYID'],
                                _categoryController.text,
                              );
                              Navigator.of(context)
                                  .pop(); // Close the confirmation dialog
                              Navigator.pop(context); // Close the bottom sheet
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> updateCategory(String categoryId, String updatedCategory) async {
    try {
      final response = await http.post(
        Uri.parse(
            "http://localhost/fyp/app/modules/placement/updatecategory.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'CATEGORYID': categoryId,
          'CATEGORY': updatedCategory,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        if (result['status'] == 'success') {
          // Successful update
          print('Category with ID $categoryId updated successfully');
        } else {
          // Error in update
          print(
              'Failed to update category with ID $categoryId. ${result['message']}');
        }
      } else {
        print(
            'Failed to update category with ID $categoryId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after updating
      fetchData();
    } catch (error) {
      print('Error updating category: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category Page',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoriesData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      categoriesData[index]['CATEGORY'],
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Category'),
                                  content: Text(
                                      'Are you sure you want to delete this category?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteCategory(categoriesData[index]
                                            ['CATEGORYID']);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            _showUpdateModal(categoriesData[index]);
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
