

import 'package:SMART/utils/dio_methods.dart';
import 'package:SMART/utils/end_points.dart';
import 'package:SMART/utils/headers.dart';

class CourseApi {
  Future<List<dynamic>> indexCourses({required String token}) async {
    final endpoint = EndPoints.indexCourses;
    print("Calling API: $endpoint");
    final response = await RemoteApi.get(
      endpoint,
      headers: {...headers, "Authorization": "Bearer $token"},
    );
    print("API Response: ${response.data}");
    return response.data as List<dynamic>;
  }

  // Future<Map<String, dynamic>> showCourse({
  //   required int courseId,
  //   required String token,
  // }) async {
  //   print("Calling API: ${EndPoints.showCourse(courseId)}");
  //   final response = await RemoteApi.get(
  //     EndPoints.showCourse(courseId),
  //     headers: {...headers, "Authorization": "Bearer $token"},
  //   );
  //   print("API Response: ${response.data}");
  //   return response.data as Map<String, dynamic>;
  // }

  // Future<Map<String, dynamic>> storeCourse({
  //   required String courseName,
  //   required String courseDetails,
  //   required String certificate,
  //   required Uint8List imageBytes, // <-- BYTES
  //   required String imageName,     // <-- FILENAME
  //   required String token,
  // }) async {
  //   print("Calling API: ${EndPoints.storeCourse}");
  //
  //   final fields = <String, dynamic>{
  //     "course_name": courseName,
  //     "course_details": courseDetails,
  //     "certificate": certificate,
  //   };
  //
  //   final response = await RemoteApi.postMultipart(
  //     url: EndPoints.storeCourse,
  //     fields: fields,
  //     fileBytes: imageBytes,
  //     fileName: imageName,
  //     filesKey: "image", // <-- make sure this matches your backend
  //     token: token,
  //   );
  //
  //   print("API Response: ${response.data}");
  //   return response.data as Map<String, dynamic>;
  // }
  //
  // Future<Map<String, dynamic>> updateCourse({
  //   required int courseId,
  //   String? courseName,
  //   String? courseDetails,
  //   String? certificate,
  //   Uint8List? imageBytes,      // ✅ optional
  //   String? imageName,          // ✅ optional
  //   required String token,
  // }) async {
  //   final fields = <String, dynamic>{
  //     "course_name": courseName,
  //     "course_details": courseDetails,
  //     "certificate": certificate,
  //   };
  //
  //   // Build multipart form-data (works with or without image)
  //   final formData = FormData();
  //
  //   // add text fields
  //   fields.forEach((k, v) => formData.fields.add(MapEntry(k, v?.toString() ?? '')));
  //
  //   // add file only if provided
  //   if (imageBytes != null) {
  //     formData.files.add(
  //       MapEntry(
  //         "image", // 🔑 must match backend
  //         MultipartFile.fromBytes(
  //           imageBytes,
  //           filename: imageName ?? 'image.png',
  //         ),
  //       ),
  //     );
  //   }
  //
  //   // IMPORTANT: do NOT set Content-Type: application/json here.
  //   final resp = await RemoteApi.post(
  //     EndPoints.updateCourse(courseId), // e.g., /api/updateCourse/{id}
  //     body: formData,
  //     headers: headersWithAuth(token)..remove('Content-Type'),
  //   );
  //
  //   return resp.data as Map<String, dynamic>;
  // }

  // Future<void> deleteCourse({
  //   required int courseId,
  //   required String token,
  // }) async {
  //   final resp = await RemoteApi.delete(
  //     EndPoints.deleteCourse(courseId),
  //     headers: {...headers, "Authorization": "Bearer $token"}..remove('Content-Type'),
  //   );
  //   // Optionally assert status:
  //   if (resp.statusCode != 200 && resp.statusCode != 204) {
  //     throw Exception('Delete failed (${resp.statusCode})');
  //   }
  // }
}
