import 'package:exam_4_month/data/models/errormessage.dart';
import 'package:exam_4_month/data/models/user.dart';
import 'package:exam_4_month/services/auth_services.dart';

class AuthRepositories{
  final _authServices = AuthServices();

  Future<Errormessage> inUser(String email,String password) async{
    final data = await _authServices.inUser(email, password);
    return data as Errormessage;
  }

  Future<Errormessage> createUser(String email,String password,UserData user) async{
    final data = await _authServices.createUser(email, password, user);
    return data as Errormessage;
  }

  Future<void> resetPassword(String email) async{
    await _authServices.resetPassword(email);
  }
}