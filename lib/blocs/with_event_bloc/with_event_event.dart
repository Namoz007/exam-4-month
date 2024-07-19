sealed class WithEventEvent{}

final class DeleteEventWithEventEvent extends WithEventEvent{
  String eventId;
  DeleteEventWithEventEvent(this.eventId);
}

final class LikeEventWithEvent extends WithEventEvent{
  String eventId;
  bool like;
  LikeEventWithEvent(this.eventId,this.like);
}

final class AddEventWithEvent extends WithEventEvent{
  int personCoutn;
  String userId;
  String eventId;

  AddEventWithEvent(this.personCoutn,this.userId,this.eventId);
}