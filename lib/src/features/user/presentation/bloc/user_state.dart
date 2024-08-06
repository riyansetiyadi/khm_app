part of 'user_bloc.dart';

abstract class UserState {
  const UserState();
}

class NyTimesInitial extends UserState {}

// --------------------Start Get Articles States-------------------- //

// Loading Get Ny Times State
class LoadingGetUserState extends UserState {}

// Error On Getting Ny Times State
class ErrorGetUserState extends UserState {
  final String errorMsg;

  ErrorGetArticlesState(this.errorMsg);
}

// Success Get Ny Times State
class SuccessGetArticlesState extends UserState {
  final List<UserModel> articles;

  SuccessGetArticlesState(this.articles);
}

// --------------------End Get Articles States-------------------- //

// --------------------Start Searching States-------------------- //

class SearchingState extends UserState {
  final List<UserModel> articles;

  SearchingState(this.articles);
}

// --------------------End Searching States-------------------- //
