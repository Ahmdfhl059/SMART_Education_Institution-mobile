import 'package:equatable/equatable.dart';

import '../../data/models/level.dart';

enum LevelsStatus { initial, loading, loaded, error }

class LevelsState extends Equatable {
  final LevelsStatus status;
  final List<Level> levels;
  final Level level;
  final String error;

  const LevelsState({
    required this.status,
    required this.levels,
    required this.level,
    required this.error,
  });

  factory LevelsState.initial() => LevelsState(
    status: LevelsStatus.initial,
    error: '',
    levels: [],
    level: Level.initial(),
  );

  @override
  List<Object> get props => [status, levels, level, error];

  LevelsState copyWith({
    LevelsStatus? status,
    List<Level>? levels,
    Level? level,
    String? error,
  }) {
    return LevelsState(
      status: status ?? this.status,
      levels: levels ?? this.levels,
      level: level ?? this.level,
      error: error ?? this.error,
    );
  }
}
