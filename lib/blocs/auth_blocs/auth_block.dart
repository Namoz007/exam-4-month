import 'package:bloc/bloc.dart';
import 'package:exam_4_month/blocs/auth_blocs/auth_bloc_event.dart';
import 'package:exam_4_month/blocs/auth_blocs/auth_bloc_state.dart';
import 'package:exam_4_month/data/models/errormessage.dart';
import 'package:exam_4_month/data/repositories/auth_repositories.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepositories _repositories;
  AuthBloc({required AuthRepositories repo})
      : _repositories = repo,
        super(InitialAuthBlocState()) {
    on<LoginAuthBlocEvent>(_loginOn);
    on<ResetPasswordAuthBlocEvent>(_resetPasswordWithEmail);
    on<CreateUserAuthBlocEvent>(_registration);
  }

  Future<void> _registration(CreateUserAuthBlocEvent event, emit) async{
    emit(LoadingAuthBlocState());
    final data = await _repositories.createUser(event.email, event.password,event.user);
    emit(LoadedAuthBlocState(data));
  }

  Future<void> _loginOn(LoginAuthBlocEvent event,emit) async{
    emit(LoadingAuthBlocState());
    final data = await _repositories.inUser(event.email, event.password);
    emit(LoadedAuthBlocState(data));
  }

  Future<void> _resetPasswordWithEmail(ResetPasswordAuthBlocEvent event,emit) async{
    emit(LoadingAuthBlocState());
    await _repositories.resetPassword(event.email);
    emit(LoadedAuthBlocState(Errormessage(isError: false, message: 'send code')));
  }


}
