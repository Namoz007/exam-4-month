import 'package:bloc/bloc.dart';
import 'package:exam_4_month/blocs/theme_bloc/theme_event.dart';
import 'package:exam_4_month/blocs/theme_bloc/theme_state.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc() : super(InitialThemeState(ThemeData.light())){
    on<LightThemeEvennt>(_lightThemeOn);
    on<DarkThemeEvent>(_darkThemeOn);
  }

  void _lightThemeOn(LightThemeEvennt event, emit){
    emit(InitialThemeState(ThemeData.light()));
  }

  void _darkThemeOn(DarkThemeEvent event, emit){
    emit(InitialThemeState(ThemeData.dark()));
  }
}