// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:estudying2/config/api_service.dart';
import 'package:estudying2/config/local_storage.dart';
import 'package:estudying2/models/course_model.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseLoading()) {
    ApiService apiService = ApiService();
    LocalStorage localStorage = LocalStorage();
    on<GetCourseList>((event, emit) async {
      try {
        if (state is CourseLoaded) {
          emit(CourseLoading());
        }
        List<CourseModel>? data =
            await apiService.fetchCourses(event.moduleID, event.type, '0');

        data?.forEach((element) async {
          element.fav = await localStorage.coursIsLiked(element);
        });

        if (data != null) {
          emit(CourseLoaded(
            data,
            !(data.length < 10),
          ));
        } else {
          emit(const CourseLoaded([], false));
        }
      } catch (e) {
        emit(CourseError());
      }
    });

    on<GetCourseListPag>((event, emit) async {
      List<CourseModel>? data =
          await apiService.fetchCourses(event.moduleID, event.type, event.page);
      data?.forEach((element) async {
        element.fav = await localStorage.coursIsLiked(element);
      });

      if (data != null) {
        data = event.oldData + data;
        if (data.length < 10) {
          emit(CourseLoaded(data, false));
        } else {
          emit(CourseLoaded(data, true));
        }
      } else {}
    });
  }
}
