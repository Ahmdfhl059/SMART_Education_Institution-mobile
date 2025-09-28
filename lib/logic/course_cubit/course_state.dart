import 'package:equatable/equatable.dart';

import '../../data/models/course.dart';

enum CoursesStatus { initial, loading, loaded, error }

class CoursesState extends Equatable {
  final CoursesStatus status;
  final List<Course> courses;
  final Course course;
  final String error;

  const CoursesState({
    required this.status,
    required this.courses,
    required this.course,
    required this.error,
  });

  factory CoursesState.initial() =>
      CoursesState(
        status: CoursesStatus.initial,
        courses: [],
        course: Course.initial(),
        error: '',
      );

  @override
  List<Object> get props => [status, courses, course, error];

  CoursesState copyWith({
    CoursesStatus? status,
    List<Course>? courses,
    Course? course,
    String? error,
  }) {
    return CoursesState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
      course: course ?? this.course,
      error: error ?? this.error,
    );
  }
}
