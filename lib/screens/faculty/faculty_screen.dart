// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:estudying2/blocs/faculty_bloc/faculty_bloc.dart';
import 'package:estudying2/screens/speciality/speciality_screen.dart';
import 'package:estudying2/widgets/cusrom_error_msg.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_load.dart';

class FacultyScreen extends StatelessWidget {
  const FacultyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "BAHDJA USTHB",
        ),
        body: BlocBuilder<FacultyBloc, FacultyState>(builder: (context, state) {
          if (state is FacultyLoading) {
            return const CustomLoad();
          } else if (state is FacultyError) {
            return const CustomErrorMsg();
          } else if (state is FacultyLoaded) {
            return ListView.builder(
                itemCount: state.data?.length ?? 0,
                itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: Text(
                          state.data![index].name!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpecialityScreen(
                                        facultyName: state.data![index].name!,
                                        facultySlug: state.data![index].slug!,
                                      )));
                        }))));
          } else {
            return Container();
          }
        }));
  }
}
