part of 'student_cubit.dart';

enum StudentStatus { initial, loading, loaded, error }

class StudentState extends Equatable {
  final StudentStatus status;
  final Student student;
  final String error;

  const StudentState({
    required this.status,
    required this.student,
    required this.error,
  });

  factory StudentState.initial() => StudentState(
    status: StudentStatus.initial,
    student: Student.initial(),
    error: '',
  );

  StudentState copyWith({
    StudentStatus? status,
    Student? student,
    String? error,
  }) {
    return StudentState(
      status: status ?? this.status,
      student: student ?? this.student,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, student, error];
}