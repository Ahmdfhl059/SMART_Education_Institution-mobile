part of 'levels_requests_cubit.dart';

enum LevelsRequestsStatus { initial, loading, loaded, error }

class LevelsRequestsState extends Equatable {
  final LevelsRequestsStatus status;
  final LevelRequest levelRequest;
  final List<LevelRequest> levelsRequests;
  final String error;

  const LevelsRequestsState({
    required this.status,
    required this.levelRequest,
    required this.levelsRequests,
    required this.error,
  });

  factory LevelsRequestsState.initial() =>
      LevelsRequestsState(
        status: LevelsRequestsStatus.initial,
        levelRequest: LevelRequest.initial(),
        levelsRequests: [],
        error: '',
      );

  LevelsRequestsState copyWith({
    LevelsRequestsStatus? status,
    LevelRequest? levelRequest,
    List<LevelRequest>? levelsRequests,
    String? error,
  }) {
    return LevelsRequestsState(
      status: status ?? this.status,
      levelRequest: levelRequest ?? this.levelRequest,
      levelsRequests: levelsRequests ?? this.levelsRequests,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, levelRequest, levelsRequests, error];
}
