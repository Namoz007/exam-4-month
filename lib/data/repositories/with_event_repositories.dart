import 'package:exam_4_month/services/with_event_services.dart';

class WithEventRepositories{
  final _services = WithEventServices();

  Future<void> addEventQuery(String userId,String eventId) async{
    await _services.addEventQuery(userId,eventId);
  }


  Future<void> deleteEvent(String eventId) async{
    await _services.deleteEvent(eventId);
  }

  Future<void> likeEvent(String eventId,bool like) async{
    await _services.likeEvent(eventId, like);
  }
}