// Package imports:
import 'package:bloc/bloc.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../config/api_service.dart';
import '../../models/faculty_model.dart';

part 'faculty_event.dart';
part 'faculty_state.dart';

class FacultyBloc extends Bloc<FacultyEvent, FacultyState> {
  final ApiService apiService = ApiService();
  FacultyBloc() : super(FacultyLoading()) {
    on<GetFacultyList>((event, emit) async {
      try {
        List<FacultyModel>? data = await apiService.fetchFaculty();

        data?.sort((a, b) =>
            removeDiacritics(a.name!).compareTo(removeDiacritics(b.name!)));

        emit(FacultyLoaded(
          data,
        ));
      } catch (e) {
        emit(FacultyError());
      }
    });
  }
}
