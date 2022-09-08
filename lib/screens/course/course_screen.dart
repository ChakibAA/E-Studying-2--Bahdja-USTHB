// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:estudying2/blocs/course_bloc/course_bloc.dart';
import '../../widgets/course/course_list_view.dart';
import '../../widgets/custom_app_bar.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key, required this.moduleID}) : super(key: key);

  final String moduleID;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  bool isLoading = true;

  static List<String> keyType = ['cours', 'td', 'tp', 'examen'];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
    BlocProvider.of<CourseBloc>(context)
        .add(GetCourseList(widget.moduleID, keyType[tabController.index]));
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        BlocProvider.of<CourseBloc>(context)
            .add(GetCourseList(widget.moduleID, keyType[tabController.index]));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cours",
      ),
      body: BlocListener<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state is CourseLoading) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is CourseLoaded) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: Column(
          children: [
            IgnorePointer(
              ignoring: isLoading,
              child: TabBar(controller: tabController, tabs: const [
                Tab(
                  text: "Cours",
                ),
                Tab(
                  text: "TD",
                ),
                Tab(
                  text: "TP",
                ),
                Tab(
                  text: "Examen",
                )
              ]),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  CourseListView(
                    moduleId: widget.moduleID,
                    label: 'cours',
                  ),
                  CourseListView(
                    moduleId: widget.moduleID,
                    label: 'td',
                  ),
                  CourseListView(
                    moduleId: widget.moduleID,
                    label: 'tp',
                  ),
                  CourseListView(
                    moduleId: widget.moduleID,
                    label: 'examen',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
