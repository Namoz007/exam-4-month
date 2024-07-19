import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String id;
  String name;
  String email;
  String? imageUrl;
  String deviceId;
  List<String> myFavoriteEvent;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl,
    required this.deviceId,
    required this.myFavoriteEvent,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      deviceId: json['deviceId'],
      myFavoriteEvent: json['myFavoriteEvent'],
    );
  }

  Map<String, dynamic> toJson(UserData user) {
    return {
      "id": id,
      "name": name,
      "email": email,
      "imageUrl": imageUrl,
      "deviceId": deviceId,
      "myFavoriteEvent": myFavoriteEvent,
    };
  }
}
