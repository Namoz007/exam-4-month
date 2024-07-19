import 'package:flutter/material.dart';

sealed class ThemeState{}

final class InitialThemeState extends ThemeState{
  ThemeData theme;

  InitialThemeState(this.theme);
}

final class LightThemeThemeState extends ThemeState{}

final class DarkThemeState extends ThemeState{}