import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_4_month/data/models/event.dart';

sealed class EventState{}

final class InitialEventState extends EventState{}

final class LoadingEventState extends EventState{}

final class LoadedEventState extends EventState{
  List<Event> events;

  LoadedEventState(this.events);
}

final class GetAllEventsEventState extends EventState{
  Stream<QuerySnapshot> stream;
  GetAllEventsEventState(this.stream);
}

final class ErrorEventState extends EventState{
  String errorMessage;

  ErrorEventState(this.errorMessage);
}