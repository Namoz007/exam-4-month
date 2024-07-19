import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_4_month/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  final _fireStore = FirebaseFirestore.instance.collection("users");
  final _fireStorage = FirebaseStorage.instance.ref();

  Future<void> getUserDetails(String email) async{
    final data = await _fireStore.where('email', isEqualTo: email).get();
    List<dynamic> listt = data.docs[0]['myFavoriteEvent'];
    String favorites = '';
    for(int i = 0;i < listt.length;i++)
      favorites += "${listt[i].toString()},";

    final pref = await SharedPreferences.getInstance();
    pref.setString("userId",data.docs[0].id).toString();
    pref.setString("userName",data.docs[0]['name']).toString();
    pref.setString("userEmail",data.docs[0]['email']).toString();
    pref.setString("userImageUrl",data.docs[0]['imageUrl']).toString();
    pref.setString("userDeviceId",data.docs[0]['deviceId']).toString();
    pref.setString('myFavoriteEvent', favorites);

  }

  Future<void> editUserDetails(UserData user, File file,String newName) async {
    final pref = await SharedPreferences.getInstance();
    try {
      print("surat yuborilmoqda");
      final _getImg = _fireStorage.child("${user.name}${UniqueKey()}");
      final data = await _getImg.putFile(file);
      final downloadURL = await _getImg.getDownloadURL();
      _fireStore.doc(user.id).update({
        "name": newName,
        "imageUrl":downloadURL
      });
      await pref.setString("userName", newName);
      await pref.setString('userImageUrl', downloadURL);
    } catch (e) {
      print("Xatolik yuz berdi: $e");
    }
  }
}
