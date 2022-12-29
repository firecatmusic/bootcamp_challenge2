part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  List<Object> get props => [];
}

class HomeLoadNoteEvent extends HomeEvent{}
class HomeLoadProfileEvent extends HomeEvent{}
