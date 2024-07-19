import 'package:bloc/bloc.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_event.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_state.dart';
import 'package:exam_4_month/data/repositories/with_event_repositories.dart';

class WithEventBloc extends Bloc<WithEventEvent,WithEventState>{
  final WithEventRepositories _repositories;
  WithEventBloc({required WithEventRepositories repo}) : _repositories = repo,super(InitialWithEventState()){
    on<DeleteEventWithEventEvent>(_deleteEvent);
    on<LikeEventWithEvent>(_likeEvent);
    on<AddEventWithEvent>(_addEventQuery);
  }

  Future<void> _addEventQuery(AddEventWithEvent event,emit) async{
    emit(LoadingWithEventState());
    await _repositories.addEventQuery(event.userId,event.eventId);
    emit(LoadedWithEventState());
  }

  Future<void> _deleteEvent(DeleteEventWithEventEvent event,emit) async{
    emit(LoadingWithEventState());
    await _repositories.deleteEvent(event.eventId);
    emit(LoadedWithEventState());
  }

  Future<void> _likeEvent(LikeEventWithEvent event,emit) async{
    emit(LoadingWithEventState());
    await _repositories.likeEvent(event.eventId, event.like);
    emit(LoadedWithEventState());
  }


}