import 'package:image_picker/image_picker.dart';

import '../../utils/secure_storage.dart';
import '../api/student_api.dart';
import '../models/student.dart';

class StudentRepo {
  final StudentApi api;

  StudentRepo(this.api);

  Future<Map<String, dynamic>> studentRegister({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String gender,
    required String birthday,
  }) async {
    try {
      final response = await api.studentRegister(
        data: {
          "email": email,
          "password": password,
          "password_confirmation": confirmPassword,
          "first_name": firstName,
          "last_name": lastName,
          "phone_number": phoneNumber,
          "gender": gender,
          "birthday": birthday,
        },
      );
      // final String status = response['status'];
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> studentLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.studentLogin(
        data: {"email": email, "password": password},
      );
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> resendVerificationCode({
    required String email,
  }) async {
    try {
      final response = await api.resendVerificationCode(data: {"email": email});
      // final String status = response['status'];
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> forgotPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await api.forgotPassword(
        data: {
          "email": email,
          "code": code,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> studentVerify({
    required String email,
    required String verificationCode,
  }) async {
    try {
      final response = await api.studentVerify(
        data: {"email": email, "verification_code": verificationCode},
      );
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }

  Future<Student> fillStudentData({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String gender,
    int? age,
  }) async {
    try {
      final response = await api.fillStudentData(
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "gender": gender,
          "phone_number": phoneNumber,
          "age": age,
          //add the age if it exists
        },
      );
      final Student student = Student.fromMap(response['data']);
      return student;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }

  Future<String> studentLogout() async {
    try {
      final response = await api.studentLogout();
      final String status = response['status'];
      return status;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }

  Future<Student> showStudentProfile() async {
    final token = await SecureStorage.getToken();
    print(token);
    if (token.isEmpty) {
      throw Exception('token is null');
    }
    print(token);
    try {
      final response = await api.showStudentProfile(token: token);
      if (response.isEmpty || response["user"] == null) {
        throw Exception('no user data');
      }
      final Student student = Student.fromMap(response["user"]);
      print('user:$student');

      return student;
    } catch (e) {
      print('error in repo  :${e.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateStudentProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String birthday,
    XFile? image,
  }) async {
    try {
      final response = await api.updateStudentProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        birthday: birthday,
        image: image,
      );
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }
}
