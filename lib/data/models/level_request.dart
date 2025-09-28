class LevelRequest {
  final int id;
  final String status;
  final String academicStage;
  final String languageLevel;
  final String time;
  final String days;
  final String learningMethod;
  final String levelName;
  final String imageUrl;
  final String courseName;

  LevelRequest({
    required this.id,
    required this.status,
    required this.academicStage,
    required this.languageLevel,
    required this.time,
    required this.days,
    required this.learningMethod,
    required this.levelName,
    required this.courseName,
    required this.imageUrl
  });

  factory LevelRequest.initial() => LevelRequest(
    id: -100,
    status: "initial data",
    academicStage: "initial data",
    languageLevel: "initial data",
    time: "initial data",
    days: "initial data",
    learningMethod: "initial data",
    levelName: "initial data",
    courseName: "initial data",
    imageUrl:  '',
  );

  factory LevelRequest.fromMap(Map<String, dynamic> map) {
    return LevelRequest(
      id: map['id'] as int? ?? -1000,
      status: map['status']?.toString() ?? "empty data",
      academicStage: map['academic_stage']?.toString() ?? "empty data",
      languageLevel: map['language_level']?.toString() ?? "empty data",
      time: map['time']?.toString() ?? "empty data",
      days: map['days']?.toString() ?? "empty data",
      learningMethod: map['learning_method']?.toString() ?? "empty data",
      levelName:
          ((map['level'] as Map<String, dynamic>?) ?? {})['name']?.toString() ??
          "empty data",
      courseName:
          ((map['course'] as Map<String, dynamic>?) ?? {})['name']
              ?.toString() ??
          "empty data",
      imageUrl:
          ((map['course'] as Map<String, dynamic>?) ?? {})['image']
              ?.toString() ??
          "empty data",
    );
  }
}
