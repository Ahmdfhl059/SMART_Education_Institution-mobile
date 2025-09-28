import 'package:SMART/shared/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/student_api.dart';
import '../../../data/repo/student_repo.dart';
import '../../../logic/auth_cubit/student_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../utils/constants.dart';
import 'login_screen.dart';

var formKey = GlobalKey<FormState>();
var passwordController = TextEditingController();
var confirmPasswordController = TextEditingController();

class ForgottenPasswordScreen extends StatelessWidget {
  final String email;
  final String code;

  const ForgottenPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LogoComponent(),
              Center(
                child: DefaultText(
                  text: 'forgot_password'.tr(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DefaultText(
                  text: 'password'.tr(context),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              CustomTextFormFiled(
                controller: passwordController,
                type: TextInputType.visiblePassword,
                prefix: Icons.lock_outlined,
                isPassword: true,
                borderColor: defaultColor,
                iconColor: secondaryColor,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "error_password".tr(context);
                  } else {}
                },
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DefaultText(
                  text: 'confirm_password'.tr(context),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              CustomTextFormFiled(
                controller: confirmPasswordController,
                type: TextInputType.visiblePassword,
                prefix: Icons.lock_outlined,
                isPassword: true,
                borderColor: defaultColor,
                iconColor: secondaryColor,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "error_password".tr(context);
                  } else {}
                },
              ),
              SizedBox(height: 40),
              BlocProvider(
                create: (context) =>
                    StudentCubit(studentRepo: StudentRepo(StudentApi())),
                child: BlocConsumer<StudentCubit, StudentState>(
                  listener: (context, state) {
                    if (state.status == StudentStatus.error) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    } else if (state.status == StudentStatus.loaded) {
                      navigateAndFinish(context, LoginScreen());
                    }
                  },
                  builder: (context, state) {
                    if (state.status == StudentStatus.loading) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: defaultColor),
                        ],
                      );
                    }
                    return DefaultButton(
                      text: 'done'.tr(context),
                      onPress: () {
                        context.read<StudentCubit>().studentForgotPassword(
                          email: email,
                          code: code,
                          password: passwordController.text,
                          passwordConfirmation: confirmPasswordController.text,
                        );
                      },
                      width: double.infinity,
                      background: defaultColor,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
