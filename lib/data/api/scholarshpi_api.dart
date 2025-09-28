import 'package:SMART/utils/dio_methods.dart';
import 'package:SMART/utils/end_points.dart';
import 'package:SMART/utils/headers.dart';

class ScholarshipApi {
  Future<List<dynamic>> indexScholarships({required String token}) async {
    final endpoint = EndPoints.indexScholarships;
    print("Calling API: $endpoint");
    final response = await RemoteApi.get(
      endpoint,
      headers: {...headers, "Authorization": "Bearer $token"},
    );
    print("API Response: ${response.data}");
    return response.data as List<dynamic>;
  }

  Future<Map<String, dynamic>> registerScholarship({
    required int scholarshipId,
    required String token,
    required Map<String, dynamic> data, //phone
  }) async {
    final response = await RemoteApi.post(
      EndPoints.registerScholarship(scholarshipId),
      headers: headersWithAuth(token),
      body: data,
    );
    return response.data;
  }

  // ---------- SHOW ----------
  // Future<Map<String, dynamic>> showScholarship({
  //   required int scholarshipId,
  //   required String token,
  // }) async {
  //   final endpoint = EndPoints.showScholarship(scholarshipId);
  //   print("Calling API: $endpoint");
  //   final response = await RemoteApi.get(
  //     endpoint,
  //     headers: {...headers, "Authorization": "Bearer $token"},
  //   );
  //   print("API Response: ${response.data}");
  //   return response.data as Map<String, dynamic>;
  // }

  // Future<Map<String, dynamic>> storeScholarship({
  //   required String name,
  //   required String description,
  //   required String typeOfFinancing,
  //   required String fundingAgency,
  //   required String achievedCertificate,
  //   required String requiredDocuments,
  //   required String advantages,
  //   required String requiredCertificates,
  //   required String submissionTime, // yyyy-MM-dd
  //   required String university,
  //   required String country,
  //   required String specialization,
  //   Uint8List? imageBytes, // <-- BYTES (required, like storeCourse)
  //   String? imageName,     // <-- FILENAME (required)
  //   required String token,         // <-- pass token in, same as storeCourse
  // }) async {
  //   print("Calling API: ${EndPoints.storeScholarship}");
  //
  //   final fields = <String, dynamic>{
  //     "name": name,
  //     "description": description,
  //     "type_of_financing": typeOfFinancing,
  //     "funding_agency": fundingAgency,
  //     "achieved_certificate": achievedCertificate,
  //     "required_documents": requiredDocuments,
  //     "advantages": advantages,
  //     "required_certificates": requiredCertificates,
  //     "submission_time": submissionTime,
  //     "university": university,
  //     "country": country,
  //     "specialization": specialization,
  //   };
  //
  //   final response = await RemoteApi.postMultipart(
  //     url: EndPoints.storeScholarship,
  //     fields: fields,
  //     fileBytes: imageBytes,
  //     fileName: imageName,
  //     filesKey: "image", // <-- must match backend
  //     token: token,
  //   );
  //
  //   print("API Response: ${response.data}");
  //   return response.data as Map<String, dynamic>;
  // }
  //
  //
  // // ---------- UPDATE (POST form-data to /updateScholarship/{id}) ----------
  // Future<Map<String, dynamic>> updateScholarship({
  //   required int scholarshipId,
  //   String? name,
  //   String? description,
  //   String? typeOfFinancing,
  //   String? fundingAgency,
  //   String? achievedCertificate,
  //   String? requiredDocuments,
  //   String? advantages,
  //   String? requiredCertificates,
  //   String? submissionTime,
  //   String? university,
  //   String? country,
  //   String? specialization,
  //   Uint8List? imageBytes,   // optional
  //   String? imageName,       // optional
  //   required String token,
  // }) async {
  //   final fields = <String, dynamic>{
  //     "name": name,
  //     "description": description,
  //     "type_of_financing": typeOfFinancing,
  //     "funding_agency": fundingAgency,
  //     "achieved_certificate": achievedCertificate,
  //     "required_documents": requiredDocuments,
  //     "advantages": advantages,
  //     "required_certificates": requiredCertificates,
  //     "submission_time": submissionTime,
  //     "university": university,
  //     "country": country,
  //     "specialization": specialization,
  //   };
  //
  //   // Build multipart form-data (works with or without image)
  //   final formData = FormData();
  //
  //   // Add text fields (send empty string when null, matching your updateCourse pattern)
  //   fields.forEach((k, v) {
  //     formData.fields.add(MapEntry(k, v?.toString() ?? ''));
  //   });
  //
  //   // Add file only if provided
  //   if (imageBytes != null) {
  //     formData.files.add(
  //       MapEntry(
  //         "image", // must match backend
  //         MultipartFile.fromBytes(
  //           imageBytes,
  //           filename: imageName ?? 'scholarship_${DateTime.now().millisecondsSinceEpoch}.png',
  //         ),
  //       ),
  //     );
  //   }
  //
  //   // IMPORTANT: do NOT set Content-Type: application/json; let Dio set multipart boundary
  //   final resp = await RemoteApi.post(
  //     EndPoints.updateScholarship(scholarshipId), // e.g., /api/updateScholarship/{id}
  //     body: formData,
  //     headers: headersWithAuth(token)..remove('Content-Type'),
  //   );
  //
  //   return resp.data as Map<String, dynamic>;
  // }
  //
  // // ---------- DELETE ----------
  // Future<void> deleteScholarship({
  //   required int scholarshipId,
  //   required String token,
  // }) async {
  //   final resp = await RemoteApi.delete(
  //     EndPoints.deleteScholarship(scholarshipId),
  //     headers: {...headers, "Authorization": "Bearer $token"}..remove('Content-Type'),
  //   );
  //   if (resp.statusCode != 200 && resp.statusCode != 204) {
  //     throw Exception('Delete failed (${resp.statusCode})');
  //   }
  // }
}
