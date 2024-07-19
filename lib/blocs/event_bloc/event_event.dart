import 'dart:io';

import 'package:exam_4_month/data/models/event.dart';

sealed class EventEvent{}

final class AddEventEventEvent extends EventEvent{
  Event event;
  File file;

  AddEventEventEvent({required this.event,required this.file});
}


final class GetAllEventsEventEvent extends EventEvent{}
