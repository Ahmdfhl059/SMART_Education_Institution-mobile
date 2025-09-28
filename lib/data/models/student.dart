

class Student {
  String? message;
  final int id;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String gender;
  String birthday;
  String? imageUrl;

  Student({
    this.message,
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.birthday,
     this.imageUrl,
  });

  factory Student.initial() => Student(
    id: -1,
    email: '',
     message: '',
    firstName: '',
    lastName: '',
    phoneNumber: '',
    gender: '',
    birthday: '',
    imageUrl: '',
  );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'message': this.message,
      'first_name': this.firstName,
      'last_name': this.lastName,
      'phone_number': this.phoneNumber,
      'gender': this.gender,
      'birthday': this.birthday,
      'image_url': this.imageUrl,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int,
      email: map['email'] ??'',
      message: map['message'] ??'',
      firstName: map['first_name']  ??'',
      lastName: map['last_name'] ??'',
      phoneNumber: map['phone_number'] ??'',
      gender: map['gender'] ??'',
      birthday: map['birthday'] ??'',
      imageUrl: map['image_url'] ??'',
    );
  }
}
