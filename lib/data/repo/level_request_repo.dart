import '../../utils/secure_storage.dart';
import '../api/levels_request_api.dart';
import '../models/level_request.dart';

class LevelsRequestRepo{
  LevelsRequestApi api;
  LevelsRequestRepo({required this.api});
  Future<List<LevelRequest>> myEnrollments() async {
    print("Repo: Fetching my Enrollments...");
    final token = await SecureStorage.getToken();
    final response = await api.myEnrollments(token: token);
    final dynamic data = response["enrollments"];
    if (data is! List) {
      print("Error: data is not a list, it's ${data.runtimeType}");
      return [];
    }

    final List<LevelRequest> levelRequests = (data)
        .map<LevelRequest>((dynamic item) {
      try {
        return LevelRequest.fromMap(item as Map<String, dynamic>);
      } catch (e) {
        print("Error parsing item: $e");
        print("Problematic item: $item");
        return LevelRequest.fromMap({});
      }
    })
        .toList();

    return levelRequests;
  }
}