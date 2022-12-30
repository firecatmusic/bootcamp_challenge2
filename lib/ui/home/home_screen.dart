import 'dart:convert';
import 'dart:io';

import 'package:bootcamp_challenge2/ui/home/home_bloc.dart';
import 'package:bootcamp_challenge2/ui/home/item/item_note.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_challenge2/core/utils/translation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/model/listnote_response.dart';
import '../../core/utils/hex_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController controller = PageController();
  final _homeBloc = HomeBloc();
  var listNote = <DataNote>[];
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    _homeBloc.add(HomeLoadNoteEvent());
    _homeBloc.add(HomeLoadProfileEvent());
    super.initState();
  }

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
    return BlocProvider(
      create: (context) => _homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccess) {
            state.response.data?.forEach((element) {
              listNote.add(element);
            });
            print(json.encode(listNote));
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeSuccess) {
              _refreshController.refreshCompleted();
              return Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 50),
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: refreshData,
                  child: ListView.builder(
                    itemCount: listNote.length,
                    itemBuilder: (context, index) =>
                        ItemNote(
                          data: listNote[index],
                          onClick: (data) => context.push('/editnote', extra: data),
                        ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  "no data",
                  style: GoogleFonts.nunito(color: Colors.black, fontSize: 14),
                ),
              );
            }
          },
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

  void refreshData() async {
    listNote.clear();
    _homeBloc.add(HomeLoadNoteEvent());
  }

  Future<void> logout(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Obtain shared preferences.
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    context.push('/');
  }
}
