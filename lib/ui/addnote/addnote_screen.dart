import 'package:bootcamp_challenge2/core/utils/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNoteScreen> {
  final _title = TextEditingController();
  final _content = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: HexColor.fromHex("#666666")),
              onPressed: () => context.pop(),
            ),
            title: Text("Add Note", style: GoogleFonts.nunito(color: HexColor.fromHex("#666666"))),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  width: double.infinity,
                  child: TextField(
                    controller: _title,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    style: GoogleFonts.poppins(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: GoogleFonts.nunito(color: HexColor.fromHex("#666666")),
                    ),
                  ),
                  // child: TextField(
                  //   controller: _title,
                  //   keyboardType: TextInputType.text,
                  //   maxLines: 1,
                  //   style: GoogleFonts.nunito(fontSize: 16, color: HexColor.fromHex("#666666")),
                  //   decoration: InputDecoration(
                  //     hintText: "Title",
                  //     hintStyle: GoogleFonts.nunito(color: HexColor.fromHex("#666666")),
                  //   ),
                  // ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  width: double.infinity,
                  child: TextField(
                    controller: _content,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.nunito(fontSize: 12, color: HexColor.fromHex("#666666")),
                    decoration: InputDecoration(
                      hintText: "Content",
                      hintStyle: GoogleFonts.nunito(color: HexColor.fromHex("#666666")),
                      contentPadding: EdgeInsets.all(16),
                    ),
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

  Future<void> validateNote() async {}
}
