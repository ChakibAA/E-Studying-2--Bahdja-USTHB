// Flutter imports:
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:

import 'package:estudying2/config/theme.dart';
import 'blocs/course_bloc/course_bloc.dart';
import 'blocs/faculty_bloc/faculty_bloc.dart';
import 'blocs/favorite_courses_bloc/favorite_courses_bloc.dart';
import 'blocs/favorite_courses_status_bloc/favorite_courses_status_bloc.dart';
import 'config/ad/app_lifecycle_reactor.dart';
import 'config/ad/app_open_manager.dart';

import 'cubits/navigation_cubit.dart';
import 'cubits/theme_cubit.dart';
import 'screens/navigation.dart';
import 'screens/no_connection_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).whenComplete(() => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool splash = true;
  bool noConnectivity = false;

  late AppLifecycleReactor appLifecycleReactor;
  late AppOpenAdManager appOpenAdManager;

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          noConnectivity = true;
        });
      } else {
        setState(() {
          noConnectivity = false;
        });
      }
    });
    appOpenAdManager = AppOpenAdManager()..loadAd();
    appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);

    _initGoogleMobileAds();
    switchSplash();
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  switchSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      splash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CourseBloc(),
          ),
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(create: (context) => ThemeCubit()..getLocalTheme()),
          BlocProvider(
            create: (context) => FacultyBloc()..add(GetFacultyList()),
          ),
          BlocProvider(
            create: (context) =>
                FavoriteCoursesStatusBloc()..add(LoadFavorites()),
          ),
          BlocProvider(
            create: (context) => FavoriteCoursesBloc(
                favoriteCoursesStatusBloc:
                    BlocProvider.of<FavoriteCoursesStatusBloc>(context))
              ..add(const UpdateFavoriteCoursesList()),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'E-Studying-dz',
                theme: Themes.light,
                darkTheme: Themes.dark,
                themeMode: state,
                home: splash
                    ? const SplashScreen()
                    : noConnectivity
                        ? const NoConnectionScreen()
                        : const Navigation());
          },
        ));
  }
}
