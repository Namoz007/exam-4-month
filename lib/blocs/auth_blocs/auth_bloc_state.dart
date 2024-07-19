import 'package:exam_4_month/data/models/errormessage.dart';

sealed class AuthBlocState{}

final class InitialAuthBlocState extends AuthBlocState{}

final class LoadingAuthBlocState extends AuthBlocState{}

final class LoadedAuthBlocState extends AuthBlocState{
  Errormessage message;

  LoadedAuthBlocState(this.message);
}

final class ErrorAuthBlocState extends AuthBlocState{}