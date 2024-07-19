import 'package:bloc/bloc.dart';
import 'package:exam_4_month/blocs/event_bloc/event_event.dart';
import 'package:exam_4_month/blocs/event_bloc/event_state.dart';
import 'package:exam_4_month/data/repositories/event_repositories.dart';

class EventBloc extends Bloc<EventEvent,EventState>{
  final EventRepositories _repositories;
  EventBloc({required EventRepositories repo}) : _repositories = repo,super(InitialEventState()){
    on<AddEventEventEvent>(_addEvent);
  }

  Future<void> _addEvent(AddEventEventEvent event,Emitter emit) async{
    emit(LoadingEventState());
    print("keldi");
    await _repositories.addNewEvent(event.event, event.file);
    emit(LoadedEventState([]));
  }

}