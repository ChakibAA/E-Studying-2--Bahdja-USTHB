part of 'speciality_bloc.dart';

abstract class SpecialityState extends Equatable {
  const SpecialityState();

  @override
  List<Object?> get props => [];
}

class SpecialityLoading extends SpecialityState {}

class SpecialityError extends SpecialityState {}

class SpecialityLoaded extends SpecialityState {
  final List<SpecialityModel> data;
  @override
  List<Object> get props => [data];
  const SpecialityLoaded(this.data);
}
