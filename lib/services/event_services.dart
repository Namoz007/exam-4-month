import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_4_month/data/models/event.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class EventServices{
  final _fireStore = FirebaseFirestore.instance.collection("events");
  final _fireStorage = FirebaseStorage.instance.ref();

  Future<void> addNewEvent(Event event,File file) async{
    final pref = await SharedPreferences.getInstance();
    final citySearch = YandexSuggest();
    final _getImgFireStorage = await _fireStorage.child("${event.eventName}${UniqueKey().toString()}");
    final _uploadImg = await _getImgFireStorage.putFile(file);
    final data = await _getImgFireStorage.getDownloadURL();
    final userId = await pref.getString('userId');

    final res = await YandexSearch.searchByPoint(point: event.point, searchOptions: SearchOptions(searchType: SearchType.geo));
    final a = (await res.$2).items?[0].name ?? "Manzil topilmadi";
    event.img = data.toString();
    event.userId = userId.toString();
    await _fireStore.add(event.toJson());
    
  }

  Stream<QuerySnapshot> getAllEvents() async*{
    yield* _fireStore.snapshots();
  }
}