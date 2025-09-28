class ScholarshipRequest {
  final int id;
  final String academicStage;
  final String schoolName;
  final String fieldOfStudy;
  final String academicYear;
  final String average;
  final bool placementTest;
  final String languageLevel;
  final String status;
  final String studentName;
  final String studentEmail;
  final String studentPhone;
  final String scholarshipName;
  final String imageUrl;

  ScholarshipRequest({
    required this.id,
    required this.status,
    required this.academicStage,
    required this.schoolName,
    required this.fieldOfStudy,
    required this.academicYear,
    required this.average,
    required this.placementTest,
    required this.languageLevel,
    required this.studentName,
    required this.studentEmail,
    required this.studentPhone,
    required this.scholarshipName,
    required this.imageUrl,
  });

  factory ScholarshipRequest.initial() => ScholarshipRequest(
    id: -111,
    status: "empty data",
    academicStage: "empty data",
    schoolName: "empty data",
    fieldOfStudy: "empty data",
    academicYear: "empty data",
    average: "-0.10",
    placementTest: false,
    languageLevel: "empty data",
    studentName: "empty data",
    studentEmail: "empty data",
    studentPhone: "empty data",
    scholarshipName: "empty data",
    imageUrl: "empty data",
  );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'academicStage': this.academicStage,
      'school_name': this.schoolName,
      'field_of_study': this.fieldOfStudy,
      'academic_year': this.academicYear,
      'average': this.average,
      'placement_test': this.placementTest,
      'languageLevel': this.languageLevel,
      'status': this.status,
      'studentName': this.studentName,
      'studentEmail': this.studentEmail,
      'studentPhone': this.studentPhone,
      'scholarshipName': this.scholarshipName,
      'image': this.imageUrl,
    };
  }

  factory ScholarshipRequest.fromMap(Map<String, dynamic> map) {
    return ScholarshipRequest(
      id: map['id'] as int? ?? -1000,
      academicStage: map['academic_stage']?.toString() ?? "empty_data",
      schoolName: map['school_name']?.toString() ?? "empty_data",
      fieldOfStudy: map['field_of_study']?.toString() ?? "empty_data",
      academicYear: map['academic_year']?.toString() ?? "empty_data",
      average: map['average']?.toString() ?? "-0.1",
      placementTest: map['placement_test'] ?? false,
      languageLevel: map['language_level']?.toString() ?? "empty_data",
      status: map['status']?.toString() ?? "empty_data",
      studentName:
          ((map['student'] ?? {}) ?? {})['name']?.toString() ?? "empty_data",
      studentEmail:
          ((map['student'] ?? {}) ?? {})['email']?.toString() ?? "empty_data",
      studentPhone:
          ((map['student'] ?? {}) ?? {})['phone']?.toString() ?? "empty_data",
      scholarshipName:
          ((map['scholarship'] ?? {}) ?? {})['name']?.toString() ??
          "empty_data",
      imageUrl:
          ((map['scholarship'] ?? {}) ?? {})['image']?.toString() ??
          "uploads/posts/1757323101_post_1757323105401.png,",
    );
  }
}
