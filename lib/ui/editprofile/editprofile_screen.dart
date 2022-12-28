import 'dart:io';

import 'package:bootcamp_challenge2/core/utils/hex_color.dart';
import 'package:bootcamp_challenge2/ui/editprofile/editprofile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _title = TextEditingController();
  final _editProfileController = EditProfileController();
  File? imageFile;
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark));
    return WillPopScope(
      onWillPop: () async {
        context.pop();
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
                Obx(() => _editProfileController.selectedImagePath.value == '' ? defaultViewProfile() : pickedImageViewProfile(File(_editProfileController.selectedImagePath.value))),
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

  Widget defaultViewProfile() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 200,
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: const DecorationImage(image: NetworkImage("https://www.kaorinusantara.or.id/english/wp-content/uploads/2022/10/bocchi4.jpg"), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(125, 0, 0, 0),
                decoration: BoxDecoration(color: HexColor.fromHex("#666666"), borderRadius: BorderRadius.circular(100)),
                child: GestureDetector(
                  onTap: () async {
                    _editProfileController.getImage();
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pickedImageViewProfile(File file) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 200,
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(125, 0, 0, 0),
                decoration: BoxDecoration(color: HexColor.fromHex("#666666"), borderRadius: BorderRadius.circular(100)),
                child: GestureDetector(
                  onTap: () async {
                    _editProfileController.getImage();
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
