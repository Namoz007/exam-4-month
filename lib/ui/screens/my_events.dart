import 'package:exam_4_month/blocs/event_bloc/event_bloc.dart';
import 'package:exam_4_month/blocs/event_bloc/event_event.dart';
import 'package:exam_4_month/blocs/event_bloc/event_state.dart';
import 'package:exam_4_month/data/models/event.dart';
import 'package:exam_4_month/data/repositories/event_repositories.dart';
import 'package:exam_4_month/ui/screens/add_event_screen.dart';
import 'package:exam_4_month/ui/screens/show_events.dart';
import 'package:exam_4_month/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyEvents extends StatefulWidget {
  String userId;
  MyEvents({super.key, required this.userId});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Meing tadbirlarim'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Tashkil qilganlarim'),
            Tab(text: 'Yaqinda'),
            Tab(
              text: "Ishtirok etganlarim",
            ),
            Tab(
              text: "Bekor qilganlarim",
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: context.read<EventRepositories>().getAllEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Malumot olishda hatolik yuz berdi"),
              );
            }

            final events = snapshot.data!.docs;
            return TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    Event event = Event.fromJson(events[index]);
                    print(event.userId);
                    return event.userId == widget.userId
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ShowEvents(event: event,edit: true,),
                          )
                        : SizedBox();
                  },
                ),
                ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {},
                ),
                ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    Event evet = Event.fromJson(events[index]);
                    return evet.addedUsers.contains(widget.userId)
                        ? ShowEvents(event: evet, edit: false,)
                        : SizedBox();
                  },
                ),
                ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    Event evet = Event.fromJson(events[index]);
                    return evet.canceledUsers.contains(widget.userId)
                        ? ShowEvents(event: evet,edit: false,)
                        : SizedBox();
                  },
                ),
              ],
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEventScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
