
import '../../utils/secure_storage.dart';
import '../api/scholarshpi_api.dart';
import '../models/scholarship.dart';

class ScholarshipRepo {
  final ScholarshipApi scholarshipApi;

  ScholarshipRepo(this.scholarshipApi);

  Future<List<Scholarship>> indexScholarships() async {
    final token = await SecureStorage.getToken();
    final response = await scholarshipApi.indexScholarships(token: token);
    final List data = response;
    return data
        .map((e) => Scholarship.fromMap(e as Map<String, dynamic>))
        .toList();
  }
  Future<Map<String, dynamic>> registerScholarship({
    required int scholarshipId,
    required String academicStage,
    required String schoolName,
    required String fieldOfStudy,
    required String academicYear,
    required String average,
    required bool placementTest,
    required String languageLevel,
  }) async {
    try {
      final token = await SecureStorage.getToken();
      final response = await scholarshipApi.registerScholarship(
        data: {
          "academic_stage": academicStage,
          "school_name": schoolName,
          "field_of_study": fieldOfStudy,
          "academic_year": academicYear,
          "average": average,
          "placement_test": placementTest,
          "language_level": languageLevel,
        },
        scholarshipId: scholarshipId,
        token: token,
      );
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }

  // Future<Scholarship> showScholarship({required int scholarshipId}) async {
  //   final token = await SecureStorage.getToken();
  //   final response = await scholarshipApi.showScholarship(
  //     scholarshipId: scholarshipId,
  //     token: token,
  //   );
  //   return Scholarship.fromMap(response['scholarship'] as Map<String, dynamic>);
  // }

  // Future<Scholarship> storeScholarship({
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
  //   final token = await SecureStorage.getToken();
  //   final response = await scholarshipApi.storeScholarship(
  //     name: name,
  //     description: description,
  //     typeOfFinancing: typeOfFinancing,
  //     fundingAgency: fundingAgency,
  //     achievedCertificate: achievedCertificate,
  //     requiredDocuments: requiredDocuments,
  //     advantages: advantages,
  //     requiredCertificates: requiredCertificates,
  //     submissionTime: submissionTime,
  //     university: university,
  //     country: country,
  //     specialization: specialization,
  //     imageBytes: imageBytes,
  //     imageName: imageName,
  //     token: token,
  //   );
  //
  //   return Scholarship.fromMap(response);
  // }
  //
  // Future<Scholarship> updateScholarship({
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
  //   Uint8List? imageBytes,
  //   String? imageName,
  // }) async {
  //   final token = await SecureStorage.getToken();
  //   final response = await scholarshipApi.updateScholarship(
  //     scholarshipId: scholarshipId,
  //     name: name,
  //     description: description,
  //     typeOfFinancing: typeOfFinancing,
  //     fundingAgency: fundingAgency,
  //     achievedCertificate: achievedCertificate,
  //     requiredDocuments: requiredDocuments,
  //     advantages: advantages,
  //     requiredCertificates: requiredCertificates,
  //     submissionTime: submissionTime,
  //     university: university,
  //     country: country,
  //     specialization: specialization,
  //     imageBytes: imageBytes,
  //     imageName: imageName,
  //     token: token,
  //
  //   );
  //   return Scholarship.fromMap(response);
  // }
  //
  // Future<void> deleteScholarship({required int scholarshipId}) async {
  //   final token = await SecureStorage.getToken();
  //   await scholarshipApi.deleteScholarship(scholarshipId: scholarshipId, token: token);
  // }
}
