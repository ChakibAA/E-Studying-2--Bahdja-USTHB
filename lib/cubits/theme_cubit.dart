// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:bloc/bloc.dart';

// Project imports:
import '../config/local_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit()
      : super(
          ThemeMode.system,
        );

  bool? darkTheme;

  void changeTheme(bool dark) {
    LocalStorage localStorage = LocalStorage();
    localStorage.setThemeMode(dark);

    dark
        ? emit(
            ThemeMode.dark,
          )
        : emit(
            ThemeMode.light,
          );
  }

  void getLocalTheme() async {
    Brightness sytemeBrightness =
        SchedulerBinding.instance.window.platformBrightness;
    LocalStorage localStorage = LocalStorage();

    darkTheme = await localStorage.getThemeMode();

    darkTheme ??= sytemeBrightness == Brightness.dark;

    darkTheme == true
        ? emit(
            ThemeMode.dark,
          )
        : emit(
            ThemeMode.light,
          );
  }
}
