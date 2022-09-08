// Flutter imports:
import 'package:flutter/material.dart';

class CustomErrorMsg extends StatelessWidget {
  const CustomErrorMsg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "Erreur \n Veuillez nous contacter !",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ));
  }
}
