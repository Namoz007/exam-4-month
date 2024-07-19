import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_4_month/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithEventServices{
  final _fireStore = FirebaseFirestore.instance.collection("events");
  
  Future<void> deleteEvent(String eventId) async{
    await _fireStore.doc(eventId).delete();
  }

  Future<void> addEventQuery(String userId,String eventId) async{
    final data = await _fireStore.doc(eventId).get();
    print("bu data ${data.data()}");
  }

  Future<void> likeEvent(String eventId,bool like) async{
    final pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId').toString();
    if(like){
      final data = await FirebaseFirestore.instance.collection("users").doc(userId).get();
      List<dynamic> listt = data['myFavoriteEvent'];
      String favorites = '';
      for(int i = 0;i < listt.length;i++)
        favorites += "${listt[i].toString()},";
      UserData user = UserData(id:data.id , name: data['name'], email: data['email'], deviceId: data['deviceId'], myFavoriteEvent: favorites.split(','));
      user.myFavoriteEvent.removeWhere((element) => element == eventId);
      await FirebaseFirestore.instance.collection("users").doc(user.id).update({
        "myFavoriteEvent": user.myFavoriteEvent.length == 0 ? [] : user.myFavoriteEvent,
      });
      favorites = '';
      for(int i = 0; i < user.myFavoriteEvent.length;i++)
        favorites += "${user.myFavoriteEvent[i]},";
      pref.setString('myFavoriteEvent', favorites);
    }else{
      final data = await FirebaseFirestore.instance.collection("users").doc(userId).get();
      List<dynamic> listt = data['myFavoriteEvent'];
      String favorites = '';
      for(int i = 0;i < listt.length;i++)
        favorites += "${listt[i].toString()},";
      UserData user = UserData(id:data.id , name: data['name'], email: data['email'], deviceId: data['deviceId'], myFavoriteEvent: favorites.split(','));
      user.myFavoriteEvent.add(eventId);
      final pref = await SharedPreferences.getInstance();
      await FirebaseFirestore.instance.collection("users").doc(user.id).update({
        "myFavoriteEvent": user.myFavoriteEvent,
      });
    }
  }
}