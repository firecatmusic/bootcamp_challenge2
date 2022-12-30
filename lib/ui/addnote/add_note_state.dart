part of 'add_note_bloc.dart';

@immutable
abstract class AddNoteState extends Equatable {
  const AddNoteState();

  List<Object> get props => [];
}

class AddNoteInitial extends AddNoteState {}

class AddNoteLoading extends AddNoteState {}

class AddNoteSuccess extends AddNoteState {
  final String message;

  const AddNoteSuccess(this.message);
}

class AddNoteError extends AddNoteState {
  final String errorMessage;

  const AddNoteError(this.errorMessage);
}
