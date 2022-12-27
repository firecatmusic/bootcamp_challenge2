import 'dart:io';

import 'package:bootcamp_challenge2/core/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _title = TextEditingController();

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: HexColor.fromHex("#666666")),
              onPressed: () => context.pop(),
            ),
            title: Text("Edit Profile", style: GoogleFonts.nunito(color: HexColor.fromHex("#666666"))),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 200,
                    margin: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(image: NetworkImage("https://www.kaorinusantara.or.id/english/wp-content/uploads/2022/10/bocchi4.jpg"), fit: BoxFit.cover),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(125, 0, 0, 0),
                        decoration: BoxDecoration(color: HexColor.fromHex("#666666"), borderRadius: BorderRadius.circular(100)),
                        child: GestureDetector(
                          onTap: () async {
                            _getFromGallery();
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: TextField(
                    controller: TextEditingController()..text = 'Crocodic Developer',
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.poppins(fontSize: 14),
                    decoration: InputDecoration(labelText: "Name", contentPadding: EdgeInsets.all(16)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 53,
                  margin: EdgeInsets.all(16),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: HexColor.fromHex("00A89D"), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      "Save",
                      style: GoogleFonts.mulish(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
