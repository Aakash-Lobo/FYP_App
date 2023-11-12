import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Center(
        child: Text(
          'Forgot Password Screen',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: HexColor("#4f4f4f"),
          ),
        ),
      ),
    );
  }
}
