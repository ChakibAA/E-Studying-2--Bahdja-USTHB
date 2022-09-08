// ignore_for_file: must_be_immutable

part of 'module_bloc.dart';

abstract class ModuleEvent extends Equatable {
  const ModuleEvent();

  @override
  List<Object> get props => [];
}

class GetModuleList extends ModuleEvent {
  final String specialityID;
  final String semsterID;

  @override
  List<Object> get props => [specialityID, semsterID];
  const GetModuleList(this.specialityID, this.semsterID);
}
