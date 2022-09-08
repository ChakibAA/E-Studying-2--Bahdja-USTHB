// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
import 'package:estudying2/widgets/custom_app_bar.dart';
import '../../config/ad/ad_helper.dart';
import '../module/module_screen.dart';

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({Key? key, required this.specialityID})
      : super(key: key);

  final String specialityID;

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Semestre'),
      body: Column(
        children: [
          Padding(
              padding:
                  const EdgeInsets.only(right: 8, bottom: 4, left: 8, top: 8),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  title: const Text(
                    'S1',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ModuleScreen(
                                  specialityID: widget.specialityID,
                                  semesterID: 's1',
                                ))));
                  })),
          Padding(
              padding:
                  const EdgeInsets.only(right: 8, bottom: 4, left: 8, top: 8),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  title: const Text(
                    'S2',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ModuleScreen(
                                  specialityID: widget.specialityID,
                                  semesterID: 's2',
                                ))));
                  })),
          const Expanded(child: SizedBox()),
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
      ),
    );
  }
}
