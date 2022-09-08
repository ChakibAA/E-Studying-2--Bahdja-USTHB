// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({required String title, IconButton? iconButton, Key? key})
      : super(
          key: key,
          toolbarHeight: 60,
          elevation: 0.2,
          title: Text(
            title,
          ),
          centerTitle: true,
          actions: [iconButton ?? Container()],
        );
}
