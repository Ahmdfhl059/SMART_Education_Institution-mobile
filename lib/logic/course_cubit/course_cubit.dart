
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/course.dart';
import '../../data/repo/course_repo.dart';
import 'course_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final CourseRepo courseRepo;

  CoursesCubit({required this.courseRepo}) : super(CoursesState.initial()){
    indexCourses();
  }

  Future<void> indexCourses() async {
    emit(state.copyWith(status: CoursesStatus.loading));
    try {
      final List<Course> courses = await courseRepo.indexCourses();
      emit(state.copyWith(status: CoursesStatus.loaded, courses: courses));
    } catch (e) {
      emit(state.copyWith(status: CoursesStatus.error, error: e.toString()));
    }
  }

  // Future<void> showCourses({required int courseId}) async {
  //   emit(state.copyWith(status: CoursesStatus.loading));
  //   try {
  //     final Course course = await courseRepo.showCourse(courseId: courseId);
  //     emit(state.copyWith(status: CoursesStatus.loaded, course: course));
  //   } catch (e) {
  //     emit(state.copyWith(status: CoursesStatus.error, error: e.toString()));
  //   }
  // }

  // Future<void> storeCourse({
  //   required String courseName,
  //   required String courseDetails,
  //   required String certificate,
  //   required Uint8List imageBytes, // <-- BYTES
  //   required String imageName, // <-- FILENAME
  // }) async {
  //   emit(state.copyWith(status: CoursesStatus.loading));
  //   try {
  //     final course = await courseRepo.storeCourse(
  //       courseName: courseName,
  //       courseDetails: courseDetails,
  //       certificate: certificate,
  //       imageBytes: imageBytes,
  //       // pass bytes
  //       imageName: imageName, // pass filename
  //     );
  //     emit(state.copyWith(status: CoursesStatus.loaded, course: course));
  //   } catch (e) {
  //     emit(state.copyWith(status: CoursesStatus.error, error: e.toString()));
  //   }
  // }
  //
  // Future<void> updateCourse({
  //   required int courseId,
  //   String? courseName,
  //   String? courseDetails,
  //   String? certificate,
  //   Uint8List? imageBytes, // ✅ optional for web
  //   String? imageName, // ✅ optional
  // }) async {
  //   emit(state.copyWith(status: CoursesStatus.loading));
  //   try {
  //     final updated = await courseRepo.updateCourse(
  //       courseId: courseId,
  //       courseName: courseName,
  //       courseDetails: courseDetails,
  //       certificate: certificate,
  //       imageBytes: imageBytes,
  //       imageName: imageName,
  //     );
  //     emit(state.copyWith(status: CoursesStatus.loaded, course: updated));
  //   } catch (e) {
  //     emit(state.copyWith(status: CoursesStatus.error, error: e.toString()));
  //   }
  // }

  // Future<void> deleteCourse({required int courseId}) async {
  //   emit(state.copyWith(status: CoursesStatus.loading));
  //   try {
  //     await courseRepo.deleteCourse(courseId: courseId);
  //     final updated = List<Course>.from(state.courses)
  //       ..removeWhere((c) => c.id == courseId);
  //     emit(state.copyWith(status: CoursesStatus.loaded, courses: updated));
  //   } catch (e) {
  //     emit(state.copyWith(status: CoursesStatus.error, error: e.toString()));
  //   }
  // }
}
