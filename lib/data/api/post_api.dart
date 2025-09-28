
import 'package:SMART/utils/dio_methods.dart';
import 'package:SMART/utils/end_points.dart';
import 'package:SMART/utils/headers.dart';

import '../../utils/secure_storage.dart' show SecureStorage;


class PostApi {
  Future<List<dynamic>> indexPosts({required String token}) async {
    final endpoint = EndPoints.indexPosts;
    print("Calling API: $endpoint");
    final response = await RemoteApi.get(
      endpoint,
      headers: {...headers, "Authorization": "Bearer $token"},
    );
    print("API Response: ${response.data}");
    return response.data as List<dynamic>;
  }

   Future<Map<String, dynamic>> like({
     required int postId,
   }) async {
    var token = SecureStorage.getToken();
    final response = await RemoteApi.post(
      EndPoints.like(postId),
      headers: headersWithAuth(await token),
    );
    return response.data;
  }
  Future<Map<String, dynamic>> disLike({
    required postId,
  }) async {
    var token = SecureStorage.getToken();
    final response = await RemoteApi.post(
      EndPoints.disLike(postId),
      headers: headersWithAuth(await token),
    );
    return response.data;
  }
}
