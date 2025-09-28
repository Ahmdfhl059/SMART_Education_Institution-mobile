import '../../utils/dio_methods.dart';
import '../../utils/end_points.dart';
import '../../utils/headers.dart';

class ScholarshipRequestApi{
  Future<List<dynamic>> myApplications({required String token,}) async {
    final response = await RemoteApi.get(
      EndPoints.myApplications,
      headers: {...headers, "Authorization": "Bearer $token"},
    );
    print("API Response: ${response.data}");
    return response.data as List<dynamic>;
  }
}
