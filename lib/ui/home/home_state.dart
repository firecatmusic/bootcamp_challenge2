part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  const HomeState();

  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final ListNoteResponse response;

  const HomeSuccess(this.response);
}

class HomeError extends HomeState {
  final String? message;

  const HomeError(this.message);
}

/// PROFILE
/// **/

class ProfileInitial extends HomeState {}

class ProfileLoading extends HomeState {}

class ProfileSuccess extends HomeState {
  final ProfileResponse response;

  const ProfileSuccess(this.response);
}

class ProfileError extends HomeState {
  final String? message;

  const ProfileError(this.message);
}
