import 'package:exam_4_month/data/models/event.dart';
import 'package:exam_4_month/data/repositories/event_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowWeakEvent extends StatefulWidget {
  const ShowWeakEvent({super.key});

  @override
  State<ShowWeakEvent> createState() => _ShowWeakEventState();
}

class _ShowWeakEventState extends State<ShowWeakEvent> {
  DateTime date = DateTime(2024,DateTime.now().month,DateTime.now().day + 7);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        StreamBuilder(
          stream: context.read<EventRepositories>().getAllEvents(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: Colors.red,),);
            }

            if(snapshot.hasError){
              return const Center(child: Text("Malumot olishda hatolik yuzaga keldi"),);
            }

            if(!snapshot.hasData){
              return const Center(child: Text("Hech qanday malumot mavjud emas"),);
            }

            final events = snapshot.data!.docs;
            return ListView.builder(
              scrollDirection:
              Axis.horizontal,
              itemCount: events.length,
              itemBuilder: (context, index) {
                Event event = Event.fromJson(events[index]);
                return date.isAfter(event.dateTime) ? Container(
                  width: MediaQuery.of(context).size.width -
                      40,
                  margin: EdgeInsets.symmetric(
                      horizontal:
                      10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "12",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  "May",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                size: 35,
                              ),),)
                        ],
                      ),
                      Text("Tadbir",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ) : SizedBox();
              },
            );
          },
        ),
      ],
    );
  }
}
