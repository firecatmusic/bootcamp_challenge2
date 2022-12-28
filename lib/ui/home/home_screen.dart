import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bootcamp_challenge2/core/utils/translation.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: Container(
              width: 64,
              height: 64,
              child: FloatingActionButton(
                //Floating action button on Scaffold
                onPressed: () {
                  //code to execute on button press
                  context.push("/addnote");
                },
                backgroundColor: HexColor.fromHex("00A89D"),
                child: Icon(Icons.add), //icon inside button
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
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
                  icon: SizedBox(child: Icon(Icons.home), width: 24, height: 24),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircleAvatar(maxRadius: 24, minRadius: 24, backgroundImage: NetworkImage("https://www.kaorinusantara.or.id/english/wp-content/uploads/2022/10/bocchi4.jpg"))),
                  label: 'Profile',
                ),
              ],
            ),
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Container(
              width: double.infinity,
              height: 56,
              alignment: Alignment.centerLeft,
              child: Text(
                "Profile",
                style: GoogleFonts.poppins(color: Colors.black),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,
                margin: EdgeInsets.fromLTRB(16, 70, 16, 34),
                child: CircleAvatar(maxRadius: 100, minRadius: 100, backgroundImage: NetworkImage("https://www.kaorinusantara.or.id/english/wp-content/uploads/2022/10/bocchi4.jpg")),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  "Crocodic Developer",
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "developer@crocodic.com",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push('/editprofile');
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Edit Profile",
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                      ),
                      Icon(Icons.person, color: Colors.black)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  logout(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
                  child: Row(children: [
                    Flexible(flex: 1, child: Text("Logout", style: GoogleFonts.poppins(fontSize: 14, color: HexColor.fromHex("#A8000B")))),
                    Flexible(child: Icon(Icons.exit_to_app, color: HexColor.fromHex("#A8000B")))
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Obtain shared preferences.
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    context.push('/');
  }
}
