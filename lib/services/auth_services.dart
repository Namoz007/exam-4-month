import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_4_month/data/models/errormessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exam_4_month/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final _authConnectDatabase = FirebaseAuth.instance;
  final _firestoreDatabase = FirebaseFirestore.instance;


  Future<Errormessage?> inUser(String email, String password) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("email", email);
    try {
      final response = await _authConnectDatabase.signInWithEmailAndPassword(email: email, password: password);
      return Errormessage(isError: false, message: 'null');
    } catch (e) {
      print("Bu xato ${e}");
      if (e.toString().contains("invalid")) {
        return Errormessage(isError: true, message: "invalid");
      } else if (e.toString().contains("already")) {
        return Errormessage(isError: true, message: 'already');
      }else{
       return Errormessage(isError: false, message: 'network');
      }
    }
  }

  Future<Errormessage> createUser(String email, String password,UserData user) async {
    try {
      final response = await _authConnectDatabase
          .createUserWithEmailAndPassword(email: email, password: password);
      final pref = await SharedPreferences.getInstance();
      final notificationToken = await pref.getString("notificationToken");
      final data = await _firestoreDatabase.collection("users").add({
        "id": user.id,
        "name": user.name,
        "email": email,
        "imageUrl": user.imageUrl,
        "deviceId": notificationToken,
      });
      await _firestoreDatabase.collection("users").doc(data.id).update({'id': data.id});
      await pref.setString("userId", data.id.toString());
      await pref.setString("userName", user.name);
      await pref.setString("userEmail", user.email);
      await pref.setString("userImageUrl", user.imageUrl ?? '');
      await pref.setString("userDeviceId", notificationToken.toString());
      return Errormessage(isError: false, message: '');
    } catch (e) {
      print("bu xato $e");
      if(e.toString().contains("network")){
        return Errormessage(isError: true, message: "network");
      }
      return Errormessage(isError: true, message: "user find");
    }
  }

  Future<void> resetPassword(String email) async {
    final response =
        await _authConnectDatabase.sendPasswordResetEmail(email: email);
  }
}
