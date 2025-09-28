



import '../../utils/secure_storage.dart';
import '../api/course_api.dart';
import '../models/course.dart';

class CourseRepo {
  final CourseApi courseApi;

  CourseRepo({required this.courseApi});

  Future<List<Course>> indexCourses() async {
    print("Repo: Fetching Courses...");
    final token = await SecureStorage.getToken();
    final response = await courseApi.indexCourses(token: token);
    final data = response;

    final List<Course> courses = data
        .map((courseMap) => Course.fromMap(courseMap as Map<String, dynamic>))
        .toList();
    return courses;
  }

  // Future<Course> showCourse({required int courseId}) async {
  //   print("Repo: Fetching Course...");
  //   final token = await SecureStorage.getToken();
  //   final response = await courseApi.showCourse(
  //     courseId: courseId,
  //     token: token,
  //   );
  //   return Course.fromMap(response);
  // }

  // Future<Course> storeCourse({
  //   required String courseName,
  //   required String courseDetails,
  //   required String certificate,
  //   required Uint8List imageBytes, // <-- BYTES
  //   required String imageName, // <-- FILENAME
  // }) async {
  //   final token = await SecureStorage.getToken();
  //   final response = await courseApi.storeCourse(
  //     courseName: courseName,
  //     courseDetails: courseDetails,
  //     certificate: certificate,
  //     imageBytes: imageBytes,
  //     imageName: imageName,
  //     token: token,
  //   );
  //   return Course.fromMap(response);
  // }
  //
  // 'Future<Course> updateCourse({
  //   required int courseId,
  //   String? courseName,
  //   String? courseDetails,
  //   String? certificate,
  //   Uint8List? imageBytes, // ✅
  //   String? imageName, // ✅
  // }) async {
  //   final token = await SecureStorage.getToken();
  //   final resp = await courseApi.updateCourse(
  //     courseId: courseId,
  //     courseName: courseName,
  //     courseDetails: courseDetails,
  //     certificate: certificate,
  //     imageBytes: imageBytes,
  //     imageName: imageName,
  //     token: token,
  //   );
  //   return Course.fromMap(resp);
  // }'

  // Future<void> deleteCourse({required int courseId}) async {
  //   final token = await SecureStorage.getToken();
  //   await courseApi.deleteCourse(courseId: courseId, token: token);
  // }
}
