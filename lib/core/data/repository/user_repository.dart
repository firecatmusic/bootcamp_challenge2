import 'dart:io';

import 'package:bootcamp_challenge2/core/data/model/getprofile_response.dart';
import 'package:bootcamp_challenge2/core/data/model/login_response.dart';

abstract class UserRepository {
  Future<LoginResponse> login(String isExpired, String email, String password);

  Future<ProfileResponse> getProfile();

  Future<ProfileResponse> updateProfile(String name, File photo);
}
