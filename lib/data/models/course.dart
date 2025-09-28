class Course {
  final int id;
  final String name;
  final String description;
  final String? certificate;
  final String imageUrl;

  Course({
     required this.id,
     required this.name,
     required this.description,
      this.certificate,
     required this.imageUrl
  });


  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'course_name': this.name,
      'course_details': this.description,
      'certificate': this.certificate,
      'image_url' : this.imageUrl,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] ??-1,
      name: map['course_name']?? '' ,
      description: map['course_details'] ?? '',
      certificate: map['certificate'] ,
      imageUrl: map['image_url'] ??'',
    );
  }
  factory Course.initial() =>
      Course(id: -1, name: 'empty data',certificate: 'empty data', description: 'empty data', imageUrl: '');

  Course copyWith({
    int? id,
    String? name,
    String? certificate,
    String? description,
    String? imageUrl,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      certificate: certificate ?? this.certificate,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
List<Course> dummyCourses = [
  Course(
      id: 101,
      name: "Flutter Mobile Development",
      description: "Comprehensive course covering Flutter framework, Dart programming, and Firebase integration",
      certificate: "Professional Mobile Developer Certificate",
      imageUrl: "https://example.com/images/flutter.jpg"
  ),
  Course(
      id: 102,
      name: "Web Design Fundamentals",
      description: "Learn HTML5, CSS3, responsive design principles and UI/UX best practices",
      certificate: "Certified Web Designer",
      imageUrl: "https://example.com/images/web-design.jpg"
  ),
  Course(
      id: 103,
      name: "Data Science Bootcamp",
      description: "Master Python, statistical analysis, machine learning, and data visualization",
      certificate: "Data Science Specialist",
      imageUrl: "https://example.com/images/data-science.jpg"
  ),
  Course(
      id: 104,
      name: "Digital Marketing Strategy",
      description: "SEO, social media marketing, content strategy, and analytics training",
      certificate: "Digital Marketing Professional",
      imageUrl: "https://example.com/images/digital-marketing.jpg"
  ),
  Course(
      id: 105,
      name: "Cybersecurity Essentials",
      description: "Network security, ethical hacking, cryptography, and threat management",
      certificate: "Cybersecurity Analyst",
      imageUrl: "https://example.com/images/cybersecurity.jpg"
  ),
];