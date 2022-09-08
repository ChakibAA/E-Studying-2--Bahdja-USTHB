// ignore_for_file: file_names, deprecated_member_use

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:estudying2/cubits/theme_cubit.dart';
import 'package:estudying2/widgets/custom_app_bar.dart';
import '../../widgets/setting/custom_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Réglage',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, state) {
                return ListTile(
                  tileColor: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: const Text(
                    'Mode sombre',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: CupertinoSwitch(
                    value: state == ThemeMode.dark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().changeTheme(value);
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 8,
            ),
            CustomTile(
              color: Theme.of(context).backgroundColor,
              title: "À propos d'e-studying dz",
              ontap: () {
                launchURL('https://e-studying-dz.com/');
              },
            ),
            const SizedBox(
              height: 8,
            ),
            CustomTile(
              color: Theme.of(context).backgroundColor,
              title: "Partager l'application",
              ontap: () {
                FlutterShare.share(
                    title: "Partager l'application",
                    text: "E-studying-dz",
                    linkUrl: 'https://e-studying-dz.com/',
                    chooserTitle: "Partager l'application");
              },
            ),
          ],
        ),
      ),
    );
  }

  void launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
