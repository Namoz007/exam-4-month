import 'package:exam_4_month/data/models/user.dart';

sealed class AuthBlocEvent {}

final class LoginAuthBlocEvent extends AuthBlocEvent {
  String email;
  String password;

  LoginAuthBlocEvent({
    required this.email,
    required this.password,
  });
}

final class ResetPasswordAuthBlocEvent extends AuthBlocEvent {
  String email;

  ResetPasswordAuthBlocEvent({required this.email});
}

final class CreateUserAuthBlocEvent extends AuthBlocEvent {
  UserData user;
  String email;
  String password;

  CreateUserAuthBlocEvent({
    required this.user,
    required this.email,
    required this.password,
  });
}
