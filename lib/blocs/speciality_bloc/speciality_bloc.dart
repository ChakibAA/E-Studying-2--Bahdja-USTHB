// Package imports:
import 'package:bloc/bloc.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:estudying2/config/api_service.dart';
import 'package:estudying2/models/speciality_model.dart';

part 'speciality_event.dart';
part 'speciality_state.dart';

class SpecialityBloc extends Bloc<SpecialityEvent, SpecialityState> {
  final ApiService apiService = ApiService();
  SpecialityBloc() : super(SpecialityLoading()) {
    on<GetSpecialityList>((event, emit) async {
      try {
        List<SpecialityModel>? data =
            await apiService.fetchSpeciality(event.faculty);

        data?.sort((a, b) =>
            removeDiacritics(a.title!).compareTo(removeDiacritics(b.title!)));

        emit(SpecialityLoaded(
          data ?? [],
        ));
      } catch (e) {
        emit(SpecialityError());
      }
    });
  }
}
