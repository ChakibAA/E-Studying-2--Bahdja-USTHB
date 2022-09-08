part of 'favorite_courses_status_bloc.dart';

abstract class FavoriteCoursesStatusState extends Equatable {
  const FavoriteCoursesStatusState();

  @override
  List<Object> get props => [];
}

class FavoriteCoursesStatusLoading extends FavoriteCoursesStatusState {}

class FavoriteCoursesStatusLoaded extends FavoriteCoursesStatusState {
  final List<CourseModel> data;
  const FavoriteCoursesStatusLoaded(this.data);
  @override
  List<Object> get props => [data];
}
