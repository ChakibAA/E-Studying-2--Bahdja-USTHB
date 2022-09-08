// ignore: depend_on_referenced_packages

// Package imports:
import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);
  void update(int value) => emit(value);
}
