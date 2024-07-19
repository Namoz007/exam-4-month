import 'package:exam_4_month/data/models/user.dart';

sealed class UserState{}

final class InitialUserState extends UserState{}

final class LoadingUserState extends UserState{}

final class LoadedUserState extends UserState{
  UserData user;

  LoadedUserState({required this.user});
}

final class ErrorUserState extends UserState{
  String errorMessage;

  ErrorUserState({required this.errorMessage});
}