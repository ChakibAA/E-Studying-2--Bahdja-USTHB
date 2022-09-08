// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
import 'package:estudying2/widgets/custom_app_bar.dart';
import '../../config/ad/ad_helper.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({Key? key, required this.url, required this.title})
      : super(key: key);

  final String url;
  final String title;

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
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
      appBar: CustomAppBar(title: widget.title),
      body: Column(
        children: [
          Expanded(
            child: const PDF().fromUrl(
              widget.url,
              placeholder: (double progress) => Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '$progress %',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              errorWidget: (dynamic error) =>
                  const Center(child: Text("Erreur")),
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
      ),
    );
  }
}
