import 'package:bootcamp_challenge2/ui/addnote/add_note_screen.dart';
import 'package:bootcamp_challenge2/ui/editprofile/editprofile_screen.dart';
import 'package:bootcamp_challenge2/ui/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'login/login_screen.dart';
import 'splash/screen/splash_screen.dart';

var router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/addnote',
    builder: (context, state) => const AddNoteScreen(isEditingNote: false),
  ),
  GoRoute(
    path: '/editnote',
    builder: (context, state) => const AddNoteScreen(isEditingNote: true),
  ),
  GoRoute(
    path: '/editprofile',
    builder: (context, state) => const EditProfileScreen(),
  ),
]);

Widget get errorPage => const Center(
      child: SizedBox(
        width: 200,
        child: Text('Error, maybe you forgot to include required obj'),
      ),
    );
