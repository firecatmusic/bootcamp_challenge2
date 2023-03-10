import 'dart:async';
import 'dart:io';

import 'package:bootcamp_challenge2/core/utils/hex_color.dart';
import 'package:bootcamp_challenge2/ui/login/login_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _validate = false;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: HexColor.fromHex("00A89D"), statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: BlocProvider(
            create: (context) => _loginBloc,
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  login(context);
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.message.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                  ));
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        header(),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(16, 65, 16, 0),
                          child: Form(
                            child: TextField(
                              controller: _email,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.poppins(fontSize: 14),
                              decoration: InputDecoration(labelText: "Email", contentPadding: EdgeInsets.all(16)),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(16, 23, 16, 16),
                          child: TextField(
                            controller: _password,
                            obscureText: _obscureText,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: GoogleFonts.poppins(fontSize: 14),
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
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
                              validateForm();
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
                  );
                },
              ),
            ),
          ),
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

  Future<void> login(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
    final bool? isLogin = prefs.getBool('isLogin');
    final String? token = prefs.getString('token');
    print(isLogin);
    print(token);
    context.push('/home');
  }

  void validateForm() {
    if (!EmailValidator.validate(_email.text.toString())) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Email yang anda masukkan tidak valid',
          style: GoogleFonts.poppins(),
        ),
      ));
    } else if (_password.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Field password tidak boleh kosong.',
          style: GoogleFonts.poppins(),
        ),
      ));
    } else {
      _loginBloc.add(GetTokenEvent(_email.text.toString(), _password.text.toString()));
    }
  }
}
