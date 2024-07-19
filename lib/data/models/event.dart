import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class Event {
  String id;
  String userId;
  String eventName;
  String description;
  DateTime dateTime;
  TimeOfDay eventTime;
  Point point;
  String img;
  String cityName;
  List<dynamic> addedUsers;
  List<dynamic> canceledUsers;

  Event({
    required this.id,
    required this.userId,
    required this.eventName,
    required this.description,
    required this.dateTime,
    required this.eventTime,
    required this.point,
    required this.img,
    required this.cityName,
    required this.addedUsers,
    required this.canceledUsers,
  });

  factory Event.fromJson(QueryDocumentSnapshot query) {
    return Event(
      id: query.id,
        userId: query['userId'],
        eventName: query['eventName'],
        description: query['description'],
        dateTime: DateTime.parse(query['dateTime']),
        eventTime: TimeOfDay(hour: int.parse("${query['time'].toString().split(":")[0]}",),minute: int.parse("${query['time'].toString().split(':')[1]}",)),
        point: Point(latitude: query['lat'], longitude: query['long']),
        img: query['img'],
        cityName: query['cityName'],
        addedUsers: query['addedUsers'],
        canceledUsers: query['canceledUsers']);
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "eventName": eventName,
      "description": description,
      "dateTime": dateTime.toString(),
      "time": "${eventTime.hour}:${eventTime.minute}",
      "lat": point.latitude,
      "long": point.longitude,
      "img": img,
      "cityName": cityName,
      "addedUsers": addedUsers,
      "canceledUsers": canceledUsers,
    };
  }
}
