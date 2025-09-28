import 'package:SMART/data/repo/level_request_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/level_request.dart';

part 'levels_requests_state.dart';

class LevelsRequestsCubit extends Cubit<LevelsRequestsState> {
  final LevelsRequestRepo levelRequestRepo;

  LevelsRequestsCubit({required this.levelRequestRepo})
    : super(LevelsRequestsState.initial()){
    indexLevelsRequests();
  }

  Future<void> indexLevelsRequests() async {
    emit(state.copyWith(status: LevelsRequestsStatus.loading));
    try {
      final List<LevelRequest> levelsRequests = await levelRequestRepo.myEnrollments();
      emit(
        state.copyWith(
          status: LevelsRequestsStatus.loaded,
          levelsRequests: levelsRequests,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: LevelsRequestsStatus.error, error: e.toString()),
      );
    }
  }

}
