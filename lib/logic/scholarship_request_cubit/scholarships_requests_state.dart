


part of 'scholarships_requests_cubit.dart';
enum ScholarshipsRequestsStatus { initial, loading, loaded, error }

class ScholarshipsRequestsState extends Equatable {
  final ScholarshipsRequestsStatus status;
  final ScholarshipRequest scholarshipRequest;
  final List<ScholarshipRequest> scholarshipsRequests;
  final String error;

  const ScholarshipsRequestsState({
    required this.status,
    required this.scholarshipRequest,
    required this.scholarshipsRequests,
    required this.error,
  });

  factory ScholarshipsRequestsState.initial() =>
      ScholarshipsRequestsState(
        status: ScholarshipsRequestsStatus.initial,
        scholarshipRequest: ScholarshipRequest.initial(),
        scholarshipsRequests: [],
        error: '',
      );

  ScholarshipsRequestsState copyWith({
    ScholarshipsRequestsStatus? status,
    ScholarshipRequest? scholarshipRequest,
    List<ScholarshipRequest>? scholarshipsRequests,
    String? error,
  }) {
    return ScholarshipsRequestsState(
      status: status ?? this.status,
      scholarshipRequest: scholarshipRequest ?? this.scholarshipRequest,
      scholarshipsRequests: scholarshipsRequests ?? this.scholarshipsRequests,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, scholarshipRequest, scholarshipsRequests, error];
}