import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyBookPage extends StatelessWidget {
  final String username;

  MyBookPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Books'),
      ),
      body: Center(
        child: Text('My Books Page for $username'),
      ),
    );
  }
}

class BookDetailPage extends StatelessWidget {
  final String bookTitle;
  final String author;
  final String imageUrl;
  final String username;
  final Function() borrowBook; // Add borrowBook parameter here

  BookDetailPage({
    required this.bookTitle,
    required this.author,
    required this.imageUrl,
    required this.username,
    required this.borrowBook, // Add borrowBook to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Image.network(
            imageUrl,
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            'Title: $bookTitle',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Author: $author',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                borrowBook, // Call the borrowBook function when the button is pressed
            child: Text('Borrow'),
          ),
        ],
      ),
    );
  }
}

class CommonLibraryPage extends StatefulWidget {
  final String username;

  CommonLibraryPage({required this.username});

  @override
  _CommonLibraryPageState createState() => _CommonLibraryPageState();
}

class _CommonLibraryPageState extends State<CommonLibraryPage> {
  List<dynamic> studentsData = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(
      Uri.parse('http://localhost/fyp/app/modules/lib/viewbook.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        studentsData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> _borrowBook(
      String bookTitle, String author, String username) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/fyp/app/common/library/borrowbook.php'),
        body: {
          'book_title': bookTitle,
          'author': author,
          'username': username,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData['message']);
      } else {
        print('Failed to borrow book');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/PortalBanner/library.jpeg'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'All Books:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: studentsData.length,
                itemBuilder: (context, index) {
                  final book = studentsData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailPage(
                            bookTitle: book['book_title'],
                            author: book['author'],
                            imageUrl:
                                'http://localhost/fyp/app/modules/lib/Images/${book['book_image']}',
                            username: widget.username,
                            borrowBook: () {
                              _borrowBook(
                                book['book_title'],
                                book['author'],
                                widget.username,
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: ProductCard(
                      productName: book['book_title'],
                      productDesc: book['author'],
                      username: widget.username,
                      imageUrl:
                          'http://localhost/fyp/app/modules/lib/Images/${book['book_image']}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: CustomSideNavigationBar(
        username: widget.username,
        onLogout: (bool isLoggingOut) {
          if (isLoggingOut) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String productDesc;
  final String username;
  final String imageUrl;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.productDesc,
    required this.username,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            // Wrap Column with SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  productDesc,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSideNavigationBar extends StatelessWidget {
  final String username;
  final Function(bool) onLogout;

  CustomSideNavigationBar({
    required this.username,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
            accountEmail: Text(username),
            currentAccountPicture: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('My Books'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyBookPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              _showExitConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit Confirmation'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/login'),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
