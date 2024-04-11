import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Common/Cafe/CafeCartPage.dart';
import 'package:flutter_application_1/Roles/Common/Cafe/CafeOrderPage.dart';
import 'package:flutter_application_1/Roles/Student/student_home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentCafePage extends StatefulWidget {
  final String username;

  StudentCafePage({required this.username});

  @override
  _StudentCafePageState createState() => _StudentCafePageState();
}

class _StudentCafePageState extends State<StudentCafePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http
        .get(Uri.parse('http://localhost/fyp/app/modules/cafe/viewmenu.php'));

    if (response.statusCode == 200) {
      setState(() {
        products = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Cafe',
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CafeCartPage(username: widget.username),
                  ),
                );
              },
            ),
          ],
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
                    image: AssetImage(
                        'assets/PortalBanner/cafe.jpeg'), // Placeholder image
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'All Items:',
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
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              productName: product['productName'],
                              productDesc: product['productDesc'],
                              productPrice: product['productPrice'],
                              imageUrl:
                                  'http://localhost/fyp/app/modules/cafe/Images/pizza-${product['productId']}.jpg',
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        productName: product['productName'],
                        productDesc: product['productDesc'],
                        productPrice: product['productPrice'],
                        imageUrl:
                            'http://localhost/fyp/app/modules/cafe/Images/pizza-${product['productId']}.jpg',
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
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String productDesc;
  final String productPrice;
  final String imageUrl;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.productDesc,
    required this.productPrice,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl), // Dynamically fetch image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                productName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Apply text overflow handling
                maxLines: 2, // Limit maximum
              ),
              SizedBox(height: 5),
              Text(
                productDesc,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 5),
              Text(
                '\$$productPrice',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String productName;
  final String productDesc;
  final String productPrice;
  final String imageUrl;

  const ProductDetailPage({
    Key? key,
    required this.productName,
    required this.productDesc,
    required this.productPrice,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              productName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              productDesc,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$$productPrice',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle order button click
              },
              child: Text('Order Now'),
            ),
          ],
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentCafePage(username: username),
                ),
              );
            },
            child: UserAccountsDrawerHeader(
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
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Your Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CafeOrderPage(username: username),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentHomePage(username: username),
                  ),
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
