import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/view/screens/auth_screens/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/student_api.dart';
import '../../../data/repo/student_repo.dart';
import '../../../logic/auth_cubit/student_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../utils/constants.dart';

var formKey = GlobalKey<FormState>();
var requestCodeEmailController = TextEditingController();

class RequestCodeScreen extends StatelessWidget {
  const RequestCodeScreen({super.key});

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
                padding: const EdgeInsets.all(8.0),
                child: DefaultText(
                  text: 'email'.tr(context),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              CustomTextFormFiled(
                controller: requestCodeEmailController,
                type: TextInputType.emailAddress,
                prefix: Icons.email_outlined,
                borderColor: defaultColor,
                iconColor: secondaryColor,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "error_email".tr(context);
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
                      var email = requestCodeEmailController;
                      navigateTo(
                        context,
                        VerificationScreen(requestCodeEmail:email.text,isLengthCode: false, registerEmail: '',),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.status == StudentStatus.loading) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator(color:defaultColor,)],
                      );
                    }
                    return DefaultButton(
                      text: 'next'.tr(context).toUpperCase(),
                      onPress: () {
                        context
                            .read<StudentCubit>()
                            .studentResendVerificationCode(
                              email: requestCodeEmailController.text,
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
