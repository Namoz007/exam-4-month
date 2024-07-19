import 'package:exam_4_month/blocs/auth_blocs/auth_block.dart';
import 'package:exam_4_month/blocs/event_bloc/event_bloc.dart';
import 'package:exam_4_month/blocs/theme_bloc/theme_bloc.dart';
import 'package:exam_4_month/blocs/theme_bloc/theme_state.dart';
import 'package:exam_4_month/blocs/user_bloc/user_bloc.dart';
import 'package:exam_4_month/blocs/with_event_bloc/with_event_bloc.dart';
import 'package:exam_4_month/data/repositories/auth_repositories.dart';
import 'package:exam_4_month/data/repositories/event_repositories.dart';
import 'package:exam_4_month/data/repositories/user_repositorie.dart';
import 'package:exam_4_month/data/repositories/with_event_repositories.dart';
import 'package:exam_4_month/firebase_options.dart';
import 'package:exam_4_month/services/push_notification_services.dart';
import 'package:exam_4_month/ui/screens/authentification.dart/login_screen.dart';
import 'package:exam_4_month/ui/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "name-here",
      options: DefaultFirebaseOptions.currentPlatform
  );
  // await Permission.location.status;
  await FirebasePushNotificationService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepositories()),
        RepositoryProvider(create: (context) => UserRepositorie()),
        RepositoryProvider(create: (context) => EventRepositories()),
        RepositoryProvider(create: (context) => WithEventRepositories()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(repo: context.read<AuthRepositories>())),
          BlocProvider(create: (context) => UserBloc(repo: context.read<UserRepositorie>())),
          BlocProvider(create: (context) => EventBloc(repo: context.read<EventRepositories>())),
          BlocProvider(create: (context) => WithEventBloc(repo: context.read<WithEventRepositories>())),
          BlocProvider(create: (context) => ThemeBloc()),
        ],
        child: BlocBuilder<ThemeBloc,ThemeState>(
          builder: (context,state){
            if(state is InitialThemeState){
              return MaterialApp(
                  theme: state.theme,
                  debugShowCheckedModeBanner: false,
                  home: StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context,snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }

                      if (snapshot.hasError)
                        return Center(
                          child: Text(
                            "Xatolik kelilb chiqdi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        );
                      print("snapshot malumot ${snapshot.data}");
                      return snapshot.data == null ? LoginScreen() : HomeScreen();
                    },
                  )
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
