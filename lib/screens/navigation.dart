// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:line_icons/line_icons.dart';

// Project imports:
import 'package:estudying2/screens/faculty/faculty_screen.dart';
import '../config/ad/ad_helper.dart';
import '../cubits/navigation_cubit.dart';
import 'like/like_screen.dart';
import 'setting/setting_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

  final screen = [
    const FacultyScreen(),
    const LikeScreen(),
    const SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<NavigationCubit, int>(
            builder: (context, index) {
              return Scaffold(
                extendBody: true,
                bottomNavigationBar: cutomNavBar(context, index),
                body: screen[index],
              );
            },
          ),
        ),
        if (_bannerAd != null)
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
          ),
      ],
    );
  }

  DotNavigationBar cutomNavBar(BuildContext context, int index) {
    return DotNavigationBar(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      currentIndex: index,
      unselectedItemColor: Colors.white,
      selectedItemColor: const Color(0xffBDA104),
      onTap: (index) {
        context.read<NavigationCubit>().update(index);
      },
      items: [
        DotNavigationBarItem(
          icon: const Icon(LineIcons.search),
        ),
        DotNavigationBarItem(
          icon: Icon(index == 1 ? LineIcons.heartAlt : LineIcons.heart),
        ),
        DotNavigationBarItem(
          icon: Icon(index == 3 ? LineIcons.userAlt : LineIcons.user),
        )
      ],
    );
  }
}
