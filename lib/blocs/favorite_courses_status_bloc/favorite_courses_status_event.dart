part of 'favorite_courses_status_bloc.dart';

abstract class FavoriteCoursesStatusEvent extends Equatable {
  const FavoriteCoursesStatusEvent();

  @override
  List<Object> get props => [];
}

class AddFavorite extends FavoriteCoursesStatusEvent {
  final CourseModel data;
  const AddFavorite(this.data);
  @override
  List<Object> get props => [data];
}

class RemoveFavorite extends FavoriteCoursesStatusEvent {
  final CourseModel data;
  const RemoveFavorite(this.data);
  @override
  List<Object> get props => [data];
}

class LoadFavorites extends FavoriteCoursesStatusEvent {}
