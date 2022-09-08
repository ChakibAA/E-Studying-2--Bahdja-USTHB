// Flutter imports:
import 'package:estudying2/blocs/course_bloc/course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:

import '../cusrom_error_msg.dart';
import '../custom_load.dart';
import 'course_card.dart';

class CourseListView extends StatefulWidget {
  const CourseListView({
    Key? key,
    required this.moduleId,
    required this.label,
  }) : super(key: key);

  final String label;
  final String moduleId;

  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  late ScrollController scrollController;

  int page = 0;
  bool call = false;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseLoaded && page != 0) {
          scrollController.jumpTo((page * 11) * 10);
          if (state.data.length == (page + 1) * 10) {
            setState(() {
              call = false;
            });
          }
        }
      },
      builder: (context, state) {
        if (state is CourseLoading) {
          return const CustomLoad();
        } else if (state is CourseError) {
          return const CustomErrorMsg();
        } else if (state is CourseLoaded) {
          return ListView.builder(
              controller: scrollController
                ..addListener(() {
                  if (scrollController.offset >=
                          scrollController.position.maxScrollExtent &&
                      !scrollController.position.outOfRange &&
                      state.pag &&
                      !call) {
                    setState(() {
                      page++;
                      call = true;
                    });
                    BlocProvider.of<CourseBloc>(context).add(GetCourseListPag(
                        widget.moduleId,
                        widget.label,
                        page.toString(),
                        state.data));
                  }
                }),
              itemCount: state.data.length,
              itemBuilder: ((context, index) => CourseCard(
                    data: state.data[index],
                    index: index,
                  )));
        } else {
          return Container();
        }
      },
    );
  }
}
