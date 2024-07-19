import 'dart:io';

import 'package:exam_4_month/data/models/user.dart';
import 'package:exam_4_month/services/user_services.dart';

class UserRepositorie{
  final _services = UserServices();

  Future<void> editUserDetails(UserData user,File file,String newName) async{
    await _services.editUserDetails(user, file,newName);
  }

  Future<void> getUserDetails(String email) async{
    await _services.getUserDetails(email);
  }
}