part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class GetCourseList extends CourseEvent {
  final String moduleID;
  final String type;

  @override
  List<Object> get props => [moduleID, type];

  const GetCourseList(this.moduleID, this.type);
}

class GetCourseListPag extends CourseEvent {
  final String moduleID;
  final String type;
  final String page;
  final List<CourseModel> oldData;

  @override
  List<Object> get props => [moduleID, type, page, oldData];

  const GetCourseListPag(this.moduleID, this.type, this.page, this.oldData);
}
