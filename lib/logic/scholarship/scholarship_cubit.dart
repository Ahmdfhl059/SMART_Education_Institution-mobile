import 'package:SMART/logic/scholarship/scholarship_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/scholarship_repo.dart';

class ScholarshipsCubit extends Cubit<ScholarshipsState> {
  final ScholarshipRepo scholarshipRepo;

  ScholarshipsCubit({required this.scholarshipRepo})
    : super(ScholarshipsState.initial()) {
    indexScholarships();
  }

  // INDEX
  Future<void> indexScholarships() async {
    emit(state.copyWith(status: ScholarshipsStatus.loading));
    try {
      final list = await scholarshipRepo.indexScholarships();
      emit(
        state.copyWith(status: ScholarshipsStatus.loaded, scholarships: list),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ScholarshipsStatus.error, error: e.toString()),
      );
    }
  }
  String testAcademicStage(String academicStage) {


    if (academicStage.contains('Pre-Secondary')) {
      return 'Pre-Secondary';
    } else if (academicStage.contains('Secondary')) {
      return 'Secondary';
    } else if (academicStage.contains('Institute')) {
      return 'Institute';
    } else if (academicStage.contains('University Degree')) {
      return 'University Degree';
    } else if (academicStage.contains('Master\'s')) {
      return 'Masters';
    } else if (academicStage.contains('PHD')) {
      return 'PhD';
    } else if (academicStage.isEmpty) {
      return '';
    }
    return academicStage;
  }

  String testLevel(String level) {

    if (level.contains('Beginner')) {
      return 'Beginner';
    } else if (level.contains('Weak-Elemantry')) {
      return 'Weak-Elementary';
    } else if (level.contains('Per-Intermediate')) {
      return 'Pre-Intermediate';
    } else if (level.contains('Intermediate')) {
      return 'Intermediate';
    } else if (level.contains('Advanced-Upper-Intermediate')) {
      return 'Advanced-Upper-Intermediate';
    } else if (level.contains('I Can\'t Decide')) {
      return 'ICantDecide';
    } else if (level.isEmpty) {
      return '';
    }
    return level;
  }

  bool testPlacementTest(String placementTest) {
    String cleanedPlacementTest = placementTest.trim().toLowerCase();

    if (cleanedPlacementTest.contains('Yes')) {
      return true;
    } else if (cleanedPlacementTest.contains('No')) {
      return false;
    } else if (cleanedPlacementTest.isEmpty) {
      return false;
    }
    return false;
  }

  Future<void> registerScholarship({
    required int scholarshipId,
    required String academicStage,
    required String schoolName,
    required String fieldOfStudy,
    required String academicYear,
    required String average,
    required String placementTest,
    required String languageLevel,
  }) async {
    try {
      emit(state.copyWith(status: ScholarshipsStatus.loading));

      final response = await scholarshipRepo.registerScholarship(
        scholarshipId: scholarshipId,
        academicStage: testAcademicStage(academicStage),
        schoolName: schoolName,
        fieldOfStudy: fieldOfStudy,
        academicYear: academicYear,
        average: average,
        placementTest: testPlacementTest(placementTest),
        languageLevel: testLevel(languageLevel),
      );

      emit(
        state.copyWith(
          status: ScholarshipsStatus.loaded,
          error: response["message"],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ScholarshipsStatus.error,
          error: "Something went wrong: ${e.toString()}",
        ),
      );
    }
  }

  // SHOW
  // Future<void> showScholarship({required int scholarshipId}) async {
  //   emit(state.copyWith(status: ScholarshipsStatus.loading));
  //   try {
  //     final item = await scholarshipRepo.showScholarship(
  //       scholarshipId: scholarshipId,
  //     );
  //     emit(
  //       state.copyWith(status: ScholarshipsStatus.loaded, scholarship: item),
  //     );
  //   } catch (e) {
  //     emit(
  //       state.copyWith(status: ScholarshipsStatus.error, error: e.toString()),
  //     );
  //   }
  // }

  // STORE
  // Future<void> storeScholarship({
  //   required String name,
  //   required String description,
  //   required String typeOfFinancing,
  //   required String fundingAgency,
  //   required String achievedCertificate,
  //   required String requiredDocuments,
  //   required String advantages,
  //   required String requiredCertificates,
  //   required String submissionTime,
  //   required String university,
  //   required String country,
  //   required String specialization,
  //   Uint8List? imageBytes,
  //   String? imageName,
  // }) async {
  //   emit(state.copyWith(status: ScholarshipsStatus.loading));
  //   try {
  //     final created = await scholarshipRepo.storeScholarship(
  //       name: name,
  //       description: description,
  //       typeOfFinancing: typeOfFinancing,
  //       fundingAgency: fundingAgency,
  //       achievedCertificate: achievedCertificate,
  //       requiredDocuments: requiredDocuments,
  //       advantages: advantages,
  //       requiredCertificates: requiredCertificates,
  //       submissionTime: submissionTime,
  //       university: university,
  //       country: country,
  //       specialization: specialization,
  //       imageBytes: imageBytes,
  //       imageName: imageName,
  //     );
  //     final list = List<Scholarship>.from(state.scholarships)..insert(0, created);
  //     emit(state.copyWith(status: ScholarshipsStatus.loaded, scholarships: list, scholarship: created));
  //   } catch (e) {
  //     emit(state.copyWith(status: ScholarshipsStatus.error, error: e.toString()));
  //   }
  // }
  //
  // // UPDATE
  // Future<void> updateScholarship({
  //   required int scholarshipId,
  //   required String name,
  //   required String description,
  //   required String typeOfFinancing,
  //   required String fundingAgency,
  //   required String achievedCertificate,
  //   required String requiredDocuments,
  //   required String advantages,
  //   required String requiredCertificates,
  //   required String submissionTime,
  //   required String university,
  //   required String country,
  //   required String specialization,
  //   Uint8List? imageBytes,
  //   String? imageName,
  // }) async {
  //   emit(state.copyWith(status: ScholarshipsStatus.loading));
  //   try {
  //     final updated = await scholarshipRepo.updateScholarship(
  //       scholarshipId: scholarshipId,
  //       name: name,
  //       description: description,
  //       typeOfFinancing: typeOfFinancing,
  //       fundingAgency: fundingAgency,
  //       achievedCertificate: achievedCertificate,
  //       requiredDocuments: requiredDocuments,
  //       advantages: advantages,
  //       requiredCertificates: requiredCertificates,
  //       submissionTime: submissionTime,
  //       university: university,
  //       country: country,
  //       specialization: specialization,
  //       imageBytes: imageBytes,
  //       imageName: imageName,
  //     );
  //
  //     final list = List<Scholarship>.from(state.scholarships);
  //     final idx = list.indexWhere((e) => e.id == scholarshipId);
  //     if (idx != -1) list[idx] = updated;
  //
  //     emit(state.copyWith(status: ScholarshipsStatus.loaded, scholarships: list, scholarship: updated));
  //   } catch (e) {
  //     emit(state.copyWith(status: ScholarshipsStatus.error, error: e.toString()));
  //   }
  // }
  //
  // // DELETE
  // Future<void> deleteScholarship({required int scholarshipId}) async {
  //   emit(state.copyWith(status: ScholarshipsStatus.loading));
  //   try {
  //     await scholarshipRepo.deleteScholarship(scholarshipId: scholarshipId);
  //     final list = List<Scholarship>.from(state.scholarships)..removeWhere((e) => e.id == scholarshipId);
  //     emit(state.copyWith(status: ScholarshipsStatus.loaded, scholarships: list));
  //   } catch (e) {
  //     emit(state.copyWith(status: ScholarshipsStatus.error, error: e.toString()));
  //   }
  // }
}
