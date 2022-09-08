// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:estudying2/blocs/favorite_courses_status_bloc/favorite_courses_status_bloc.dart';
import 'package:estudying2/config/local_storage.dart';
import 'package:estudying2/models/course_model.dart';

part 'favorite_courses_event.dart';
part 'favorite_courses_state.dart';

class FavoriteCoursesBloc
    extends Bloc<FavoriteCoursesEvent, FavoriteCoursesState> {
  LocalStorage localStorage = LocalStorage();
  late StreamSubscription statusSubscription;
  FavoriteCoursesStatusBloc favoriteCoursesStatusBloc;

  FavoriteCoursesBloc({required this.favoriteCoursesStatusBloc})
      : super(FavoriteCoursesLoading()) {
    statusSubscription = favoriteCoursesStatusBloc.stream.listen((state) {
      if (state is FavoriteCoursesStatusLoaded) {
        add(UpdateFavoriteCoursesList(data: state.data));
      }
    });
    on<UpdateFavoriteCoursesList>(_onUpdateFavoriteCoursesList);
  }

  void _onUpdateFavoriteCoursesList(event, emit) async {
    try {
      List<CourseModel>? data = await localStorage.getFavCourses();
      emit(FavoriteCoursesLoaded(data: data ?? []));
    } catch (e) {
      emit(FavoriteCoursesError());
    }
  }

  @override
  Future<void> close() {
    statusSubscription.cancel();

    return super.close();
  }
}
