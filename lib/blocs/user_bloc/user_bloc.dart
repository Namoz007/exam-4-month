import 'package:bloc/bloc.dart';
import 'package:exam_4_month/blocs/user_bloc/user_event.dart';
import 'package:exam_4_month/blocs/user_bloc/user_state.dart';
import 'package:exam_4_month/data/models/user.dart';
import 'package:exam_4_month/data/repositories/user_repositorie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserData? user;
  final UserRepositorie _userRepositories;
  UserBloc({required UserRepositorie repo})
      : _userRepositories = repo,
        super(InitialUserState()) {
    on<GetUserDetailsUserEvent>(_getUserDetails);
    on<GetUserDetailsInSharedPreferences>(_getUserDetailsInSharedPreferences);
    on<EditUserDetailsUserEvent>(_editUserDetails);
  }

  Future<void> _editUserDetails(EditUserDetailsUserEvent event, emit) async {
    emit(LoadingUserState());
    final data = await _userRepositories.editUserDetails(
        user!, event.img, event.newName);
    await _getUserDetailsInSharedPreferences(
        GetUserDetailsInSharedPreferences(), emit);
    emit(LoadedUserState(user: user!));
  }

  void _getUserDetails(GetUserDetailsUserEvent event, emit) {
    emit(LoadingUserState());
    emit(LoadedUserState(user: user!));
  }

  Future<void> _getUserDetailsInSharedPreferences(
      GetUserDetailsInSharedPreferences event, emit) async {
    emit(LoadingUserState());
    final pref = await SharedPreferences.getInstance();
    String emaill = pref.getString('email').toString();
    await _userRepositories.getUserDetails(emaill);
    String id = pref.getString("userId").toString();
    String name =  pref.getString("userName").toString();
    String email =  pref.getString("userEmail").toString();
    String imgUrl = pref.getString("userImageUrl").toString();
    String deviceId = pref.getString("userDeviceId").toString();
    String lst = pref.getString("myFavoriteEvent").toString();
    print("ullkdfasfdas f$lst");
    List<String> myFavoriteEvent = lst.split(',');
    user = UserData(
        id: id,
        name: name,
        email: email,
        imageUrl: imgUrl == 'null' || imgUrl == null
            ? "https://cdn4.iconfinder.com/data/icons/gray-user-management/512/rounded-1024.png"
            : imgUrl,
        deviceId: deviceId,
      myFavoriteEvent: myFavoriteEvent,
    );
    print("yuklab bolindi");
    emit(LoadedUserState(user: user!));
  }
}
