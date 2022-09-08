part of 'favorite_courses_bloc.dart';

abstract class FavoriteCoursesEvent extends Equatable {
  const FavoriteCoursesEvent();

  @override
  List<Object> get props => [];
}

class UpdateFavoriteCoursesList extends FavoriteCoursesEvent {
  final List<CourseModel> data;
  const UpdateFavoriteCoursesList({this.data = const <CourseModel>[]});

  @override
  List<Object> get props => [data];
}
