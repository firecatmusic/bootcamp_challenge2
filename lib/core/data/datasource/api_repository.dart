import 'package:bootcamp_challenge2/core/data/datasource/api_provider.dart';
import 'package:bootcamp_challenge2/core/data/model/add_note_response.dart';
import 'package:bootcamp_challenge2/core/data/model/listnote_response.dart';
import 'package:bootcamp_challenge2/core/data/model/login_response.dart';
import 'package:bootcamp_challenge2/core/data/model/register_response.dart';

import '../model/getprofile_response.dart';
import '../model/gettoken_response.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<GetTokenResponse> getToken() {
    return _provider.getToken();
  }

  Future<LoginResponse> login(String email, String password) {
    return _provider.login(email, password);
  }

  Future<RegisterResponse> register(String email, String password, String name) {
    return _provider.register(email, password, name);
  }

  Future<ProfileResponse> getProfile() {
    return _provider.getProfile();
  }

  Future<ListNoteResponse> getAllNote() {
    return _provider.getAllNote();
  }

  Future<AddNoteResponse> addNewNote(String title,String content){
    return _provider.addNewNote(title, content);
  }
}

class NetworkError extends Error {}
