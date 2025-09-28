import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/level.dart';
import '../../data/repo/level_repo.dart';
import 'level_state.dart';

class LevelCubit extends Cubit<LevelsState> {
  final LevelRepo levelRepo;

  LevelCubit({required this.levelRepo}) : super(LevelsState.initial());

  Future<void> indexLevels({required int courseId}) async {
    emit(state.copyWith(status: LevelsStatus.loading));
    try {
      final List<Level> levels = await levelRepo.indexLevels(
        courseId: courseId,
      );
      emit(state.copyWith(status: LevelsStatus.loaded, levels: levels));
    } catch (e) {
      emit(state.copyWith(status: LevelsStatus.error, error: e.toString()));
    }
  }

  String testAcademicStage(String academicStage) {

    if (academicStage.contains('Pre-Secondary')) {
      return 'pre-secondary';
    } else if (academicStage.contains('Secondary')) {
      return 'secondary';
    } else if (academicStage.contains('Institute')) {
      return 'institute';
    } else if (academicStage.contains('University Degree')) {
      return 'university';
    } else if (academicStage.contains('Master\'s')) {
      return 'masters';
    } else if (academicStage.contains('PHD')) {
      return 'phd';
    } else if (academicStage.isEmpty) {
      return '';
    }
    return academicStage;
  }

  String testLevel(String level) {

    if (level.contains('Beginner')) {
      return 'beginner';
    } else if (level.contains('Weak-Elemantry')) {
      return 'weak-elementary';
    } else if (level.contains('Per-Intermediate')) {
      return 'pre-intermediate';
    } else if (level.contains('Intermediate')) {
      return 'intermediate';
    } else if (level.contains('Advanced-Upper-Intermediate')) {
      return 'advanced-upper-intermediate';
    } else if (level.contains('I Can\'t Decide')) {
      return 'i-cant-decide';
    } else if (level.isEmpty) {
      return '';
    }
    return level;
  }

  String testDays(String days) {

    if (days.contains('Tue-Thu-Wed')) {
      return 'tue-thu-wed';
    } else if (days.contains('sat-sun-mon')) {
      return 'sat-sun-mon';
    } else if (days.isEmpty) {
      return '';
    }
    return days;
  }
  String testLearningMethod(String learningMethod) {

    if (learningMethod.contains('At SMART Foundation In Damascus')) {
      return 'at-smart-foundation';
    } else if (learningMethod.contains('Online')) {
      return 'online';
    } else if (learningMethod.isEmpty) {
      return '';
    }
    return learningMethod;
  }

  Future<void> registerLevel({
    required int levelId,
    required String academicStage,
    required String languageLevel,
    required String time,
    required String days,
    required String learningMethod,
  }) async {
    try {
      emit(state.copyWith(status: LevelsStatus.loading));

      final response = await levelRepo.registerLevel(
        levelId: levelId,
        academicStage: testAcademicStage(academicStage),
        languageLevel: testLevel(languageLevel),
        time: time,
        days: testDays(days),
        learningMethod: testLearningMethod(learningMethod),
      );

      emit(
        state.copyWith(status: LevelsStatus.loaded, error: response["message"]),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LevelsStatus.error,
          error: "Something went wrong: ${e.toString()}",
        ),
      );
    }
  }



  // Future<void> showLevel({required int levelId}) async {
  //   emit(state.copyWith(status: LevelsStatus.loading));
  //   try {
  //     final Level level = await levelRepo.showLevel(levelId: levelId);
  //     emit(state.copyWith(status: LevelsStatus.loaded, level: level));
  //   } catch (e) {
  //     emit(state.copyWith(status: LevelsStatus.error, error: e.toString()));
  //   }
  // }
}
