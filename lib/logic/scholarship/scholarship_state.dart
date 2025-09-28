import 'package:equatable/equatable.dart';

import '../../data/models/scholarship.dart';

enum ScholarshipsStatus { initial, loading, loaded, error }

class ScholarshipsState extends Equatable {
  final ScholarshipsStatus status;
  final Scholarship scholarship;
  final List<Scholarship> scholarships;
  final String error;

  const ScholarshipsState({
    required this.status,
    required this.scholarship,
    required this.scholarships,
    required this.error,
  });

  ScholarshipsState copyWith({
    ScholarshipsStatus? status,
    Scholarship? scholarship,
    List<Scholarship>? scholarships,
    String? error,
  }) {
    return ScholarshipsState(
      status: status ?? this.status,
      scholarship: scholarship ?? this.scholarship,
      scholarships: scholarships ?? this.scholarships,
      error: error ?? this.error,
    );
  }

  factory ScholarshipsState.initial() => ScholarshipsState(
    status: ScholarshipsStatus.initial,
    scholarship: Scholarship.initial(),
    scholarships: [],
    error: '',
  );

  @override
  List<Object> get props => [status, scholarship, scholarships, error];
}
