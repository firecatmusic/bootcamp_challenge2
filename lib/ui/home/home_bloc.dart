import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bootcamp_challenge2/core/data/datasource/sharedpref/shared_pref.dart';
import 'package:bootcamp_challenge2/core/data/model/getprofile_response.dart';
import 'package:bootcamp_challenge2/core/data/model/listnote_response.dart';
import 'package:bootcamp_challenge2/core/data/model/login_response.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../core/data/datasource/api_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    final apiRepo = ApiRepository();
    final strProfileImage = ''.obs;

    on<HomeLoadNoteEvent>((event, emit) async {
      emit(HomeLoading());
      final response = await apiRepo.getAllNote();
      if (response.message == "success") {
        emit(HomeSuccess(response));
      } else {
        emit(HomeError(response.message));
      }
    });

    on<HomeLoadProfileEvent>((event, emit) async {
      var profileString = await SharedPref().readJson('user');
      print(profileString);
      final body = LoginResponse.fromJson(profileString);
      strProfileImage.value = "${body.data?.photo}";
      // dataUser.value = body.data;
    });
  }
}
