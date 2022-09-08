// Flutter imports:
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0474bd),
      body: Center(
        child: Image.asset(
          'assets/logo/bahdja_remove_bg.png',
          height: 150,
        ),
      ),
    );
  }
}
