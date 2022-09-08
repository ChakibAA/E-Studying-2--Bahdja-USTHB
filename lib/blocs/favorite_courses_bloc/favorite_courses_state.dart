part of 'favorite_courses_bloc.dart';

abstract class FavoriteCoursesState extends Equatable {
  const FavoriteCoursesState();

  @override
  List<Object> get props => [];
}

class FavoriteCoursesLoading extends FavoriteCoursesState {}

class FavoriteCoursesError extends FavoriteCoursesState {}

class FavoriteCoursesLoaded extends FavoriteCoursesState {
  final List<CourseModel> data;
  const FavoriteCoursesLoaded({this.data = const <CourseModel>[]});

  @override
  List<Object> get props => [data];
}
