import 'package:exam_4_month/blocs/theme_bloc/theme_bloc.dart';
import 'package:exam_4_month/blocs/theme_bloc/theme_event.dart';
import 'package:exam_4_month/blocs/theme_bloc/theme_state.dart';
import 'package:exam_4_month/blocs/user_bloc/user_bloc.dart';
import 'package:exam_4_month/blocs/user_bloc/user_event.dart';
import 'package:exam_4_month/blocs/user_bloc/user_state.dart';
import 'package:exam_4_month/ui/screens/home_screen.dart';
import 'package:exam_4_month/ui/screens/my_events.dart';
import 'package:exam_4_month/ui/screens/profile_details/profile_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void initState(){
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              BlocBuilder<UserBloc,UserState>(builder: (context,state){
                if(state is LoadingUserState){
                  context.read<UserBloc>().add(GetUserDetailsUserEvent());
                  return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                }

                if(state is LoadedUserState){
                  return  Column(
                    children: [
                      ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(state.user.imageUrl.toString()),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: Column(
                          children: [
                            Text(
                              state.user.name,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text("${state.user.email}")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 5,
                        color: Colors.grey,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        },
                        leading: Icon(Icons.home),
                        title: Text("Asosiy sahifa"),
                        trailing: Icon(Icons.navigate_next_rounded),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => MyEvents(userId: state.user.id,)));
                        },
                        leading: Icon(Icons.confirmation_num_outlined),
                        title: Text("Mening tadbirlarim"),
                        trailing: Icon(Icons.navigate_next_rounded),
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileDetails()));
                        },
                        leading: Icon(Icons.person),
                        title: Text("Profil Ma'lumotlari"),
                        trailing: Icon(Icons.navigate_next_rounded),
                      ),
                      ListTile(
                          leading: Icon(Icons.language),
                          title: Text("Tilni o'zgartirish"),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.language),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: Text("uz"),
                                ),
                                PopupMenuItem(
                                  child: Text("eng"),
                                ),
                              ];
                            },
                          )),
                      BlocBuilder<ThemeBloc,ThemeState>(
                        builder: (context,state){
                          if(state is InitialThemeState){
                            return ListTile(
                              leading: Icon(Icons.sunny),
                              title: Text("Tungi/Kunduzgi holat"),
                              trailing: InkWell(
                                onTap: (){
                                  state.theme == ThemeData.light() ? context.read<ThemeBloc>().add(DarkThemeEvent()) : context.read<ThemeBloc>().add(LightThemeEvennt());
                                },
                                child: state.theme == ThemeData.light() ? Icon(Icons.nightlight) : Icon(Icons.sunny),
                              ),
                            );
                          }

                          return Container();
                        },
                      )
                    ],
                  );
                }
                return CircularProgressIndicator();
              },),
            ],
          ),

          ListTile(
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
            title: Text("Hisobdan chiqish"),
            trailing: Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
