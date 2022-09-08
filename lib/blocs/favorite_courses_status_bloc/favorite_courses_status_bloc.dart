// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:estudying2/models/course_model.dart';
import '../../config/local_storage.dart';

part 'favorite_courses_status_event.dart';
part 'favorite_courses_status_state.dart';

class FavoriteCoursesStatusBloc
    extends Bloc<FavoriteCoursesStatusEvent, FavoriteCoursesStatusState> {
  LocalStorage localStorage = LocalStorage();
  FavoriteCoursesStatusBloc() : super(FavoriteCoursesStatusLoading()) {
    on<LoadFavorites>((event, emit) async {
      List<CourseModel>? data = await localStorage.getFavCourses();
      emit(FavoriteCoursesStatusLoaded(data ?? []));
    });

    on<AddFavorite>((event, emit) async {
      await localStorage.addFavCourse(event.data);

      List<CourseModel>? data = await localStorage.getFavCourses();

      emit(FavoriteCoursesStatusLoaded(data ?? []));
    });

    on<RemoveFavorite>((event, emit) async {
      await localStorage.deleteFavCourse(event.data);

      List<CourseModel>? data = await localStorage.getFavCourses();

      emit(FavoriteCoursesStatusLoaded(data ?? []));
    });
  }
}
