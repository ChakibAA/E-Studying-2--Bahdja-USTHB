part of 'speciality_bloc.dart';

abstract class SpecialityEvent extends Equatable {
  const SpecialityEvent();
  @override
  List<Object> get props => [];
}

class GetSpecialityList extends SpecialityEvent {
  final String faculty;
  @override
  List<Object> get props => [faculty];
  const GetSpecialityList(this.faculty);
}
