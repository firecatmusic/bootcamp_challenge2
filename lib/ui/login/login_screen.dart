import 'package:bootcamp_challenge2/core/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: HexColor.fromHex("00A89D"), statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.light));
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            header(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(16, 65, 16, 0),
              child: TextField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.poppins(fontSize: 14),
                decoration: InputDecoration(labelText: "Email", contentPadding: EdgeInsets.all(16)),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(16, 23, 16, 16),
              child: TextField(
                obscureText: _obscureText,
                enableSuggestions: false,
                autocorrect: false,
                style: GoogleFonts.poppins(fontSize: 14),
                textAlign: TextAlign.start,
                keyboardType: TextInputType.visiblePassword,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Password",
                  suffixIcon: new GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 53,
              margin: EdgeInsets.all(16),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: HexColor.fromHex("00A89D"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                onPressed: () {
                  context.push('/home');
                },
                child: Text(
                  "Login",
                  style: GoogleFonts.mulish(color: Colors.white),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 53,
              margin: EdgeInsets.all(16),
              child: OutlinedButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                onPressed: () {
                  context.push('/register');
                },
                child: Text(
                  "Register",
                  style: GoogleFonts.mulish(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(color: HexColor.fromHex("00A89D"), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0))),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child: Text("My Notes", style: GoogleFonts.poppins(fontSize: 24, color: Colors.white)),
            alignment: Alignment.centerLeft,
          ),
          Align(child: Text("Please login with your email and password", style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)), alignment: Alignment.centerLeft),
        ],
      ),
    );
  }
}
