import 'dart:io';

sealed class UserEvent {}

final class EditUserDetailsUserEvent extends UserEvent {
  String newName;
  File img;

  EditUserDetailsUserEvent({
    required this.newName,
    required this.img,
  });
}


final class GetUserDetailsUserEvent extends UserEvent{}

final class GetUserDetailsInSharedPreferences extends UserEvent{}