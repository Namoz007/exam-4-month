import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_4_month/data/models/event.dart';
import 'package:exam_4_month/services/event_services.dart';

class EventRepositories{
  final _services = EventServices();

  Future<void> addNewEvent(Event event,File file) async{
    await _services.addNewEvent(event, file);
  }



  Stream<QuerySnapshot> getAllEvents() async*{
    yield* _services.getAllEvents();
  }
}