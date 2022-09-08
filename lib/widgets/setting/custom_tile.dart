// Flutter imports:
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile(
      {Key? key, required this.title, required this.ontap, this.color})
      : super(key: key);

  final String title;
  final void Function() ontap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: color,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
      ),
      onTap: ontap,
    );
  }
}
