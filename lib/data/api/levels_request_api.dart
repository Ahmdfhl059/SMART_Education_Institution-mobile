import '../../utils/dio_methods.dart';
import '../../utils/end_points.dart';
import '../../utils/headers.dart';

class LevelsRequestApi{
  Future<Map<String,dynamic>> myEnrollments({required String token,}) async {
    final response = await RemoteApi.get(
      EndPoints.myEnrollments(),
      headers: {...headers, "Authorization": "Bearer $token"},
    );
    print("API Response: ${response.data}");
    return response.data as Map<String,dynamic>;
  }
}
