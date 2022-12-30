import 'package:bootcamp_challenge2/core/utils/hex_color.dart';
import 'package:bootcamp_challenge2/ui/addnote/add_note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/data/model/listnote_response.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key, this.data, this.isEditingNote});

  final bool? isEditingNote;
  final DataNote? data;

  @override
  State<AddNoteScreen> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNoteScreen> {
  final _title = TextEditingController();
  final _content = TextEditingController();
  final _addNoteBloc = AddNoteBloc();

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
          body: BlocProvider(
            create: (context) => _addNoteBloc,
            child: BlocListener<AddNoteBloc, AddNoteState>(
              listener: (context, state) {
                if (state is AddNoteSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.message.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                  ));
                  context.pop();
                } else if (state is AddNoteError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.errorMessage.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                  ));
                }
              },
              child: BlocBuilder<AddNoteBloc, AddNoteState>(
                builder: (context, state) {
                  return SingleChildScrollView(
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
                              validateNote(_title.text.toString(), _content.text.toString());
                            },
                            child: Text(
                              "Save",
                              style: GoogleFonts.mulish(color: Colors.white),
                            ),
                          ),
                        ),
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

  Future<void> validateNote(String title, String content) async {
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Field title tidak boleh kosong",
          style: GoogleFonts.poppins(),
        ),
      ));
    } else if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Field content tidak boleh kosong",
          style: GoogleFonts.poppins(),
        ),
      ));
    } else {
      _addNoteBloc.add(AddNewNoteEvent(title, content));
    }
  }
}
