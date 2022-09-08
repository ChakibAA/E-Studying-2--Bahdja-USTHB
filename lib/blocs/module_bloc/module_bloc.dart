// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:estudying2/models/module_model.dart';
import '../../config/api_service.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  ModuleBloc() : super(ModuleLoading()) {
    final ApiService apiService = ApiService();

    on<GetModuleList>((event, emit) async {
      try {
        List<ModuleModel>? data =
            await apiService.fetchModule(event.specialityID, event.semsterID);

        emit(ModuleLoaded(
          data,
        ));
      } catch (e) {
        emit(ModuleError());
      }
    });
  }
}
