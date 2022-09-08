part of 'faculty_bloc.dart';

abstract class FacultyState extends Equatable {
  const FacultyState();

  @override
  List<Object> get props => [];
}

class FacultyLoading extends FacultyState {}

class FacultyError extends FacultyState {}

class FacultyLoaded extends FacultyState {
  final List<FacultyModel>? data;

  const FacultyLoaded(this.data);
}
