// Flutter imports:
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
      backgroundColor: Colors.white,
      indicatorColor: Colors.black,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff0474bd)),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      listTileTheme: ListTileThemeData(
          tileColor: const Color(0xff036584).withOpacity(0.1),
          enableFeedback: true),
      tabBarTheme: const TabBarTheme(
          labelColor: Colors.black, unselectedLabelColor: Colors.grey),
      primaryColor: const Color(0xff0474bd));

  static final dark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(20, 4, 115, 189),
      backgroundColor: const Color.fromARGB(20, 4, 115, 189),
      indicatorColor: Colors.white,
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          backgroundColor: Color(0xff002a37)),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      tabBarTheme: const TabBarTheme(
          labelColor: Colors.white, unselectedLabelColor: Colors.grey),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff002a37)),
      listTileTheme: ListTileThemeData(
          tileColor: const Color(0xffE7F6F2).withOpacity(0.2),
          enableFeedback: true),
      primaryColor: const Color(0xff002a37));
}
