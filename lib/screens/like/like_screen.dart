// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:demoji/demoji.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

// Project imports:
import 'package:estudying2/blocs/favorite_courses_bloc/favorite_courses_bloc.dart';
import 'package:estudying2/widgets/cusrom_error_msg.dart';
import 'package:estudying2/widgets/custom_load.dart';
import '../../blocs/favorite_courses_status_bloc/favorite_courses_status_bloc.dart';
import '../../widgets/course/pdf_viewer.dart';
import '../../widgets/custom_app_bar.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Liste des favoris",
        ),
        body: BlocBuilder<FavoriteCoursesBloc, FavoriteCoursesState>(
          builder: (context, state) {
            if (state is FavoriteCoursesLoading) {
              return const CustomLoad();
            } else if (state is FavoriteCoursesError) {
              return const CustomErrorMsg();
            } else if (state is FavoriteCoursesLoaded) {
              if (state.data.isEmpty) {
                return emptyList();
              } else {
                return listView(state);
              }
            } else {
              return Container();
            }
          },
        ));
  }

  ListView listView(FavoriteCoursesLoaded state) {
    return ListView.builder(
        itemCount: state.data.length,
        itemBuilder: ((context, index) => Padding(
            padding:
                const EdgeInsets.only(right: 8, bottom: 4, left: 8, top: 8),
            child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                trailing: IconButton(
                  icon: const Icon(
                    LineIcons.heartAlt,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    if (state.data[index].fav == true) {
                      context
                          .read<FavoriteCoursesStatusBloc>()
                          .add(RemoveFavorite(state.data[index]));
                    }
                  },
                ),
                title: Text(
                  state.data[index].title!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PDFViewer(
                                title: state.data[index].title!,
                                url: state.data[index].courseFile!,
                              )));
                }))));
  }

  Center emptyList() {
    return const Center(
      child: Text(
        'Votre liste des favoris \n est vide ... ${Demoji.cry}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
