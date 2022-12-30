import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/data/model/listnote_response.dart';
import '../../../core/utils/hex_color.dart';

class ItemNote extends StatelessWidget {
  const ItemNote({super.key, required this.data, required this.onClick});

  final DataNote data;
  final Function(DataNote) onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: HexColor.fromHex("#CFCFCF"), // Set border color
            width: 1), // Set border width
        borderRadius: BorderRadius.all(Radius.circular(16)), // Set rounded corner radius
      ),
      child: GestureDetector(
        onTap: () => onClick(data),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(data.title.toString(), style: GoogleFonts.nunito(color: Colors.black, fontSize: 14)),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(data.content.toString(), style: GoogleFonts.nunito(color: Colors.black, fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
