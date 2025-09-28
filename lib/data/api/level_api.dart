
import '../../utils/dio_methods.dart';
import '../../utils/end_points.dart';
import '../../utils/headers.dart';

class LevelApi {
  Future<dynamic> indexLevels({required int courseId,required String token}) async {
    final response = await RemoteApi.get(
      EndPoints.indexLevels(courseId),
      headers: {...headers, "Authorization": "Bearer $token"},
    );
    return response.data;
  }
  Future<Map<String, dynamic>> registerLevel({
    required int levelId,
    required String token,
    required Map<String, dynamic> data, //phone
  }) async {
    final response = await RemoteApi.post(
      EndPoints.registerLevel(levelId),
      headers: headersWithAuth(token),
      body: data,
    );
    return response.data;
  }


  // Future<Map<String, dynamic>> showLevel({required int levelId}) async {
  //   final response = await RemoteApi.get(
  //     EndPoints.showLevel(levelId),
  //     headers: headers,
  //   );
  //   return response.data;
  // }
}
