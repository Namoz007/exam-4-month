import 'package:exam_4_month/blocs/user_bloc/user_bloc.dart';
import 'package:exam_4_month/blocs/user_bloc/user_event.dart';
import 'package:exam_4_month/blocs/user_bloc/user_state.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_bloc.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_event.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_state.dart';
import 'package:exam_4_month/data/models/event.dart';
import 'package:exam_4_month/ui/widgets/show_event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ShowEvents extends StatefulWidget {
  Event event;
  bool edit;
  ShowEvents({super.key, required this.event,required this.edit});

  @override
  State<ShowEvents> createState() => _ShowEventsState();
}

class _ShowEventsState extends State<ShowEvents> {
  String? eventAddres;

  void initState(){
    super.initState();
    Future.delayed(Duration.zero,()async{
      final res = await YandexSearch.searchByPoint(point: widget.event.point, searchOptions: SearchOptions(searchType: SearchType.geo));
      final a = (await res.$2).items?[0].name ?? "Manzil topilmadi";
      setState(() {
        eventAddres = a;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowEventDetails(event: widget.event,me: widget.edit)));
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade400, width: 5),
          ),
          child: BlocBuilder<WithEventBloc,WithEventState>(
            builder: (context,state){
              if(state is LoadingWithEventState){
                return const Center(child: CircularProgressIndicator(color: Colors.red,),);
              }
              return Row(
                children: [
                  Stack(
                      children: [
                        Container(
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(widget.event.img), fit: BoxFit.cover),
                          ),
                        ),
                        widget.edit != null ? Align(
                          alignment: Alignment.topLeft,
                          child: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            color: Colors.grey.shade400,
                            iconColor: Colors.green,
                            itemBuilder: (context){
                              return [
                                PopupMenuItem(child: InkWell(
                                    child: Text("Tahrirlash")),),
                                PopupMenuItem(child: InkWell(
                                    onTap: (){
                                      context.read<WithEventBloc>().add(DeleteEventWithEventEvent(widget.event.id));
                                    },
                                    child: Text("O'chirish")),),
                              ];
                            },
                          ),
                        ) : SizedBox(),
                      ]
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text(
                          "${widget.event.eventName}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                        ),
                      ),
                      Text(
                        "${widget.event.eventTime.hour}:${widget.event.eventTime.minute} ~ ${widget.event.dateTime.day}/${widget.event.dateTime.month}/${widget.event.dateTime.year}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_sharp),
                              Text(
                                  "${eventAddres == null ? "Aniqlanmoqda" : eventAddres}")
                            ],
                          ),
                          BlocBuilder<UserBloc,UserState>(
                            builder: (context,state){
                              if(state is InitialUserState){
                                return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                              }

                              if(state is LoadedUserState){
                                return InkWell(
                                  onTap: () {
                                    print(state.user.myFavoriteEvent);
                                    print(widget.event.id);
                                    print(state.user.myFavoriteEvent.contains(widget.event.id));
                                    context.read<WithEventBloc>().add(LikeEventWithEvent(widget.event.id, state.user.myFavoriteEvent.contains(widget.event.id)));
                                  },
                                  child: Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: Colors.white),
                                      child: BlocBuilder<UserBloc,UserState>(
                                        builder: (context,state){
                                          if(state is InitialUserState){
                                            return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                                          }

                                          if(state is LoadedUserState){
                                            return state.user.myFavoriteEvent.contains(widget.event.id) ? Icon(Icons.favorite,color: Colors.red,) : Icon(Icons.favorite_border);
                                          }

                                          return Container();
                                        },
                                      )
                                  ),
                                );
                              }

                              return Container();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ],
              );
            },
          )),
    );
  }
}
