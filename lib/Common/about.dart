import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final String username;

  AboutPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'About Us',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Project: College ERP System',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Developed by Aakash and Aditi',
                style: TextStyle(
                  fontFamily: 'Raleway',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to our College ERP System project! We are Aakash and Aditi, the creators behind this innovative solution designed to streamline administrative tasks and enhance communication within educational institutions.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
