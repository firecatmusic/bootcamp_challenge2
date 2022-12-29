import 'dart:async';
import 'dart:io';

import 'package:bootcamp_challenge2/core/utils/hex_color.dart';
import 'package:bootcamp_challenge2/ui/register/register_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscure1Text = true;
  bool _obscure2Text = true;

  final _email = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  final _registerBloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.dark));
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        return false;
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: BlocProvider(
            create: (context) => _registerBloc,
            child: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Berhasil mendaftar",
                      style: GoogleFonts.poppins(),
                    ),
                  ));
                  context.pop();
                }
                if (state is RegisterError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.message.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                  ));
                }
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: Text(
                    'Register',
                    style: GoogleFonts.poppins(color: HexColor.fromHex("00A89D")),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: HexColor.fromHex("00A89D")),
                    onPressed: () => context.pop(),
                  ),
                ),
                body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [];
                  },
                  body: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(16, 32, 16, 0),
                        child: TextField(
                          controller: _name,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(fontSize: 14),
                          decoration: InputDecoration(labelText: "Name", contentPadding: EdgeInsets.all(16)),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(16, 32, 16, 0),
                        child: TextField(
                          controller: _email,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(fontSize: 14),
                          decoration: InputDecoration(labelText: "Email", contentPadding: EdgeInsets.all(16)),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(16, 32, 16, 0),
                        child: TextField(
                          controller: _password,
                          obscureText: _obscure1Text,
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
                                  _obscure1Text = !_obscure1Text;
                                });
                              },
                              child: new Icon(_obscure1Text ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(16, 32, 16, 40),
                        child: TextField(
                          controller: _confirmPassword,
                          obscureText: _obscure2Text,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: GoogleFonts.poppins(fontSize: 14),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Confirm Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscure2Text = !_obscure2Text;
                                });
                              },
                              child: new Icon(_obscure2Text ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                floatingActionButton: Container(
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
                      validateFormInvite();
                    },
                    child: Text(
                      "Save",
                      style: GoogleFonts.mulish(color: Colors.white),
                    ),
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateFormInvite() {
    if (_name.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Field nama tidak boleh kosong',
          style: GoogleFonts.poppins(),
        ),
      ));
    } else if (!EmailValidator.validate(_email.text.toString())) {
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
    } else if (_password.text.toString().length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Password minimal 8 karakter',
          style: GoogleFonts.poppins(),
        ),
      ));
    } else if (_confirmPassword.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Field konfirmasi password tidak boleh kosong.',
          style: GoogleFonts.poppins(),
        ),
      ));
    } else if (_confirmPassword.text.toString() != _password.text.toString()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Password tidak sama',
          style: GoogleFonts.poppins(),
        ),
      ));
    } else {
      _registerBloc.add(RegisterUserEvent(_email.text.toString(), _password.text.toString(), _name.text.toString()));
    }
  }
}
