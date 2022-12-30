import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../core/data/datasource/api_repository.dart';

part 'add_note_event.dart';

part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  AddNoteBloc() : super(AddNoteInitial()) {
    final apiRepo = ApiRepository();

    on<AddNewNoteEvent>((event, emit) async {
      emit(AddNoteLoading());
      var title = event.title;
      var content = event.content;
      final response = await apiRepo.addNewNote(title, content);
      if (response.message == "success") {
        emit(AddNoteSuccess("Berhasil membuat note"));
      } else {
        emit(AddNoteError(response.message.toString()));
      }
    });

    on<EditNoteEvent>((event, emit) async {});
  }
}
