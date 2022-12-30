part of 'add_note_bloc.dart';

abstract class AddNoteEvent extends Equatable {
  const AddNoteEvent();

  List<Object> get props => [];
}


class AddNewNoteEvent extends AddNoteEvent {
  String title;
  String content;

  AddNewNoteEvent(this.title, this.content);
}

class EditNoteEvent extends AddNoteEvent {
  int id;
  String title;
  String content;

  EditNoteEvent(this.id, this.title, this.content);
}
