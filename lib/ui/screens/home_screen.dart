import 'package:exam_4_month/blocs/user_bloc/user_bloc.dart';
import 'package:exam_4_month/blocs/user_bloc/user_event.dart';
import 'package:exam_4_month/data/models/event.dart';
import 'package:exam_4_month/data/repositories/event_repositories.dart';
import 'package:exam_4_month/ui/screens/search_textfield.dart';
import 'package:exam_4_month/ui/screens/show_events.dart';
import 'package:exam_4_month/ui/screens/show_weak_event.dart';
import 'package:exam_4_month/ui/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchTadbir = TextEditingController();
  void initState(){
    super.initState();
    context.read<UserBloc>().add(GetUserDetailsInSharedPreferences());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Bosh sahifa"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: 35,
                ),
                Container(
                  height: 12,
                  width: 12,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                )
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchTextfield(searchController: _searchTadbir),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Yaqin 7 kun ichida",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          ShowWeakEvent(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Barcha tadbirlar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Expanded(
                    child: StreamBuilder(
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
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            Event event = Event.fromJson(events[index]);
                            print(event.userId);
                            return ShowEvents(event: event, edit: false);
                          },
                        );
                      },
                    )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
