import 'package:flutter/material.dart';
import 'package:bootcamp_challenge2/core/utils/translation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/hex_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
          floatingActionButton: Container(
            width: 64,
            height: 64,
            child: FloatingActionButton(
              //Floating action button on Scaffold
              onPressed: () {
                //code to execute on button press
              },
              backgroundColor: HexColor.fromHex("00A89D"),
              child: Icon(Icons.add), //icon inside button
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: PageView(
            controller: controller,
            children: <Widget>[
              _homePage(),
              _profilePage(),
            ],
            onPageChanged: (page) {
              setState(() {
                _selectedIndex = page;
              });
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onTappedBar,
            currentIndex: _selectedIndex,
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    controller.jumpToPage(value);
  }

  Widget _homePage() {
    return Container(
      child: Center(
        child: Text(
          'Home Page',
          style: GoogleFonts.mulish(color: Colors.black),
        ),
      ),
    );
  }

  Widget _profilePage() {
    return Container(
      child: Center(
        child: Text('Profile Page', style: GoogleFonts.mulish(color: Colors.black)),
      ),
    );
  }
}
