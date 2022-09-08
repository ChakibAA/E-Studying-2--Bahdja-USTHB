part of 'module_bloc.dart';

abstract class ModuleState extends Equatable {
  const ModuleState();

  @override
  List<Object> get props => [];
}

class ModuleLoading extends ModuleState {}

class ModuleError extends ModuleState {}

class ModuleLoaded extends ModuleState {
  final List<ModuleModel>? data;

  const ModuleLoaded(
    this.data,
  );
}
