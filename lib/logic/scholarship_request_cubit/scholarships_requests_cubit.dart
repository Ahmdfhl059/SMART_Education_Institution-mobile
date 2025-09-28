
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/scholarship_request .dart';
import '../../data/repo/scholarship_recuest_repo.dart';

part 'scholarships_requests_state.dart';

class ScholarshipsRequestsCubit extends Cubit<ScholarshipsRequestsState> {
  final ScholarshipRequestRepo scholarshipRequestRepo;

  ScholarshipsRequestsCubit({required this.scholarshipRequestRepo})
      : super(ScholarshipsRequestsState.initial()){
    scholarshipRequest();
  }

  Future<void> scholarshipRequest() async {
    emit(state.copyWith(status: ScholarshipsRequestsStatus.loading));
    try {
      final List<ScholarshipRequest> scholarshipRequest = await scholarshipRequestRepo.myApplications();
      emit(
        state.copyWith(
          status: ScholarshipsRequestsStatus.loaded,
          scholarshipsRequests: scholarshipRequest,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ScholarshipsRequestsStatus.error, error: e.toString()),
      );
    }
  }
}

