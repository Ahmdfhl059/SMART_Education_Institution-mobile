
import '../../utils/secure_storage.dart';
import '../api/level_api.dart';
import '../models/level.dart';

class LevelRepo {
  final LevelApi levelApi;

  LevelRepo({required this.levelApi});

  Future<List<Level>> indexLevels({required int courseId}) async {
    final token = await SecureStorage.getToken();
    final List<dynamic> levelsData = await levelApi.indexLevels(courseId: courseId,token: token);
    List<Level> levels = levelsData.map((item) => Level.fromMap(item)).toList();
    return levels;
  }
  Future<Map<String, dynamic>> registerLevel({
    required int levelId,
    required String academicStage,
    required String languageLevel,
    required String time,
    required String days,
    required String learningMethod,

  }) async {
    try {
      final token = await SecureStorage.getToken();
      final response = await levelApi.registerLevel(
        data: {
          "academic_stage":academicStage,
          "language_level":languageLevel,
          "time":time,
          "days":days,
          "learning_method":learningMethod
        },
        levelId: levelId,
        token: token,
      );
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }


  // Future<Level> showLevel({required int levelId}) async {
  //   final response = await levelApi.showLevel(levelId: levelId);
  //   Level level = Level.fromMap(response);
  //   return level;
  // }
}
