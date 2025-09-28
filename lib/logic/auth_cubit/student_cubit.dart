import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


import '../../data/models/student.dart';
import '../../data/repo/student_repo.dart';
import '../../utils/secure_storage.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final StudentRepo studentRepo;

  StudentCubit({required this.studentRepo}) : super(StudentState.initial()) {
    showStudentProfile();
  }

  Future<void> studentLogin({
    required String email,
    required String password,
  }) async {
    try {
      emit(state.copyWith(status: StudentStatus.loading));

      final response = await studentRepo.studentLogin(
        email: email,
        password: password,
      );
      if (response["token"] != null) {
        // Store the token securely
        await SecureStorage.storeToken(response["token"]);
        print(response["token"]);
        emit(
          state.copyWith(
            status: StudentStatus.loaded,
            student: Student(
              id: response["user"]["id"],
              email: response["user"]["email"],
              firstName: '',
              lastName: '',
              phoneNumber: '',
              gender: '',
              birthday: '',
              imageUrl: '',
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: StudentStatus.error,
            error: response["message"] ?? "Login failed",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentStatus.error,
          error: "Something went wrong: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> studentRegister({
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
      emit(state.copyWith(status: StudentStatus.loading));
      final response = await studentRepo.studentRegister(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        gender: gender,
        birthday: birthday,
      );
      emit(
        state.copyWith(
          status: StudentStatus.loaded,
          error: response["message"] ?? "The email has already been taken.",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentStatus.error,
          error: "Something went wrong: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> studentForgotPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      emit(state.copyWith(status: StudentStatus.loading));

      final response = await studentRepo.forgotPassword(
        email: email,
        code: code,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      emit(
        state.copyWith(
          status: StudentStatus.loaded,
          error: response["message"] ?? "forgotPassword failed",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentStatus.error,
          error: "forgotPassword failed: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> studentVerify({
    required String email,
    required String verificationCode,
  }) async {
    try {
      emit(state.copyWith(status: StudentStatus.loading));

      final response = await studentRepo.studentVerify(
        email: email,
        verificationCode: verificationCode,
      );
      emit(
        state.copyWith(
          status: StudentStatus.loaded,
          error: response["message"] ?? "verification code failed",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentStatus.error,
          error: "verification Code failed: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> studentResendVerificationCode({required String email}) async {
    try {
      emit(state.copyWith(status: StudentStatus.loading));

      final response = await studentRepo.resendVerificationCode(email: email);
      emit(
        state.copyWith(
          status: StudentStatus.loaded,
          error: response["message"] ?? "resend verification code failed",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentStatus.error,
          error: "resend verification code  failed: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> studentLogout() async {
    try {
      emit(state.copyWith(status: StudentStatus.loading));

      await studentRepo.studentLogout();

      // بعد نجاح تسجيل الخروج امسح التوكن
      await SecureStorage.removeToken();

      emit(StudentState.initial()); // reset state to initial
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentStatus.error,
          error: "Logout failed: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> showStudentProfile() async {
    emit(state.copyWith(status: StudentStatus.loading));
    try {
      final Student student = await studentRepo.showStudentProfile();
      emit(state.copyWith(status: StudentStatus.loaded, student: student));
    } catch (e) {
      emit(state.copyWith(status: StudentStatus.error, error: e.toString()));
    }
  }

  Future<void> updateStudentProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String birthday,
    XFile? image,
  }) async {
    emit(state.copyWith(status: StudentStatus.loading));
    try {
      final response = await studentRepo.updateStudentProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        birthday: birthday,
        image: image,
      );
      emit(
        state.copyWith(
          status: StudentStatus.loaded,
          student: Student(
            message: response["message"],
            id: response["user"]["id"],
            email: response["user"]["email"],
            firstName: response["user"]["first_name"],
            lastName: response["user"]["last_name"],
            phoneNumber: response["user"]["phone_number"],
            gender: response["user"]["gender"],
            birthday: response["user"]["birthday"],
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StudentStatus.error, error: e.toString()));
    }
  }
}
