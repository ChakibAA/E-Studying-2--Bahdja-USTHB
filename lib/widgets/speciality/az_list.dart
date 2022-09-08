// ignore_for_file: must_be_immutable

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:azlistview/azlistview.dart';

// Project imports:
import '../../models/speciality_model.dart';
import '../../screens/semester/semester_screen.dart';

// Project imports:


class AZList extends StatelessWidget {
  const AZList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<SpecialityModel> data;

  @override
  Widget build(BuildContext context) {
    return AzListView(
        padding: const EdgeInsets.only(bottom: 90),
        hapticFeedback: true,
        indexBarItemHeight: 20,
        indexHintBuilder: (context, hint) => indexHintWidget(context, hint),
        indexBarOptions: IndexBarOptions(
            selectTextStyle: const TextStyle(
              color: Colors.white,
            ),
            selectItemDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor.withOpacity(0.5)),
            needRebuild: true,
            indexHintAlignment: Alignment.centerRight),
        data: data,
        itemCount: data.length,
        itemBuilder: ((context, index) => Padding(
            padding: const EdgeInsets.only(right: 25, left: 8, top: 8),
            child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                  data[index].title!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  data[index].schoolYear!,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SemesterScreen(
                                specialityID: data[index].id.toString(),
                              ))));
                }))));
  }

  Container indexHintWidget(BuildContext context, String hint) {
    return Container(
      alignment: Alignment.center,
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Theme.of(context).primaryColor),
      child: Text(
        hint,
        style: const TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }
}
