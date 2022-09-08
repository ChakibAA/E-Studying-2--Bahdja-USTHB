part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseLoading extends CourseState {}

class CourseError extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseModel> data;
  final bool pag;

  @override
  List<Object> get props => [data, pag];

  const CourseLoaded(this.data, this.pag);
}
