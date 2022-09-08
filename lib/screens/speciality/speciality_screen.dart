// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:estudying2/blocs/speciality_bloc/speciality_bloc.dart';
import '../../widgets/cusrom_error_msg.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_load.dart';
import '../../widgets/speciality/az_list.dart';

class SpecialityScreen extends StatelessWidget {
  const SpecialityScreen(
      {Key? key, required this.facultyName, required this.facultySlug})
      : super(key: key);
  final String facultyName;
  final String facultySlug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SpecialityBloc()..add(GetSpecialityList(facultySlug)),
      child: Scaffold(
        appBar: CustomAppBar(
          title: facultyName,
        ),
        body: BlocBuilder<SpecialityBloc, SpecialityState>(
            builder: (context, state) {
          if (state is SpecialityLoading) {
            return const CustomLoad();
          } else if (state is SpecialityLoaded) {
            return AZList(
              data: state.data,
            );
          } else if (state is SpecialityError) {
            return const CustomErrorMsg();
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
