
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebasePushNotificationService {
  static final _pushNotification = FirebaseMessaging.instance;

  static Future<void> init() async {
    final pref = await SharedPreferences.getInstance();
    final notificationSettings = await _pushNotification.requestPermission();

    final token = await _pushNotification.getToken();
    pref.setString("notificationToken", token.toString());
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});

    // foregroundda xabar kelsa ishlaydi
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('DASTURDA BO\'LGANDA XABAR KELDI');
      print('Xabar: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification!.title}');
      }
    });

    await FirebaseMessaging.instance.subscribeToTopic("Motivatsiya");
  }

  static void sendNotificationMessage(int count,String eventId,bool me) async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 5));
    final jsonCredentials = await rootBundle.loadString('service-account.json');

    var accountCredentials =
    ServiceAccountCredentials.fromJson(jsonCredentials);

    var scopes = ['https://www.googleapis.com/auth/cloud-platform'];
    
    String token = '';
    String userId = pref.getString("userId").toString();
    
    if(!me){
      final data = await FirebaseFirestore.instance.collection("events").doc(eventId).get();
      List<dynamic> lst = [];
      List<dynamic> datalst = data['addedUsers'];
      final res = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: data['userId']).get();
      token = res.docs[0]['deviceId'].toString();
      for(int i = 0;i < datalst.length;i++){
        lst.add(datalst[i]);
      }
      for(int i = 0;i < count; i++)
        lst.add(userId);

      await FirebaseFirestore.instance.collection("events").doc(eventId).update({
        "addedUsers": lst
      });
    }

    final client = await clientViaServiceAccount(accountCredentials, scopes);
    final name = pref.getString('userName');
    print("bu token $token");
    final notificationData = {
      'message': {
        'token':
        token,
        'notification': {
          'title': "$name sizning tadbiringizga qoshildi",
          'body': "U sizning tadbiringizga qo'shilmoqchi",
        }
      },
    };

    print("xabar ketdi");
    const projectId = "exam-1911c";
    Uri url = Uri.parse(
        "https://fcm.googleapis.com/v1/projects/$projectId/messages:send");

    final response = await client.post(
      url,
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${client.credentials.accessToken}',
      },
      body: jsonEncode(notificationData),
    );

    client.close();
    if (response.statusCode == 200) {
      print("YUBORILDI");
    }

    // print('Notification Sending Error Response status: ${response.statusCode}');
    // print('Notification Response body: ${response.body}');
  }
}
