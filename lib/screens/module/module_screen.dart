// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
import 'package:estudying2/blocs/module_bloc/module_bloc.dart';
import 'package:estudying2/screens/course/course_screen.dart';
import 'package:estudying2/widgets/cusrom_error_msg.dart';
import '../../config/ad/ad_helper.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_load.dart';

// ignore: must_be_immutable
class ModuleScreen extends StatefulWidget {
  const ModuleScreen(
      {Key? key, required this.specialityID, required this.semesterID})
      : super(key: key);

  final String specialityID;
  final String semesterID;

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  final ScrollController scrollController = ScrollController();

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

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocProvider(
            create: (_) => ModuleBloc()
              ..add(GetModuleList(widget.specialityID, widget.semesterID)),
            child: Scaffold(
              extendBody: true,
              appBar: CustomAppBar(
                title: "Module",
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocBuilder<ModuleBloc, ModuleState>(
                      builder: (context, state) {
                    if (state is ModuleLoading) {
                      return const CustomLoad();
                    } else if (state is ModuleError) {
                      return const CustomErrorMsg();
                    } else if (state is ModuleLoaded) {
                      return Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 24),
                              itemCount: state.data?.length,
                              itemBuilder: ((context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 4, left: 8, top: 8),
                                  child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      title: Text(
                                        state.data![index].title!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    CourseScreen(
                                                      moduleID: state
                                                          .data![index].id
                                                          .toString(),
                                                    ))));
                                      })))));
                    }

                    // }
                    else {
                      return Container();
                    }
                  })
                ],
              ),
            ),
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
}
