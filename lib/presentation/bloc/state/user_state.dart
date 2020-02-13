import 'package:indoxx1/data/indoxxi/model/user.dart';

abstract class UserState {}

class UserErrorState extends UserState {
  @override
  String toString() => "UserErrorState";
}

class UserUninitializedState extends UserState {
  @override
  String toString() => "UserUninitializedState";
}

class UserLoadingState extends UserState {
  @override
  String toString() => "UserLoadingState";
}

class UserLoadedState extends UserState {
  final UserModel res;

  UserLoadedState({
    this.res
  });

  @override
  String toString() => "UserLoadedState";
}

class UserAddNewState extends UserState {
  final String res;

  UserAddNewState({this.res});

  @override
  String toString() => "UserAddNewState";
}