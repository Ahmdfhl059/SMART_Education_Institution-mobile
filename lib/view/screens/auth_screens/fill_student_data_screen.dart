import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/view/screens/auth_screens/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';

import '../../../data/api/student_api.dart';
import '../../../data/repo/student_repo.dart';
import '../../../logic/auth_cubit/student_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../utils/constants.dart';

var formKey = GlobalKey<FormState>();
var radiokey = GlobalKey<FlutterRadioGroupState>();
var firstNameStudentController = TextEditingController();
var lastNameStudentController = TextEditingController();
var phoneNumberStudentController = TextEditingController();
String _selectedGender = '';

class FillStudentDataScreen extends StatelessWidget {
  final String email;
  final String password;
  final String confirmPassword;

  const FillStudentDataScreen({
    super.key,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoComponent(),
                Center(
                  child: DefaultText(
                    text: 'student_information'.tr(context),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultText(
                    text: 'first_name'.tr(context),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                CustomTextFormFiled(
                  controller: firstNameStudentController,
                  type: TextInputType.name,
                  prefix: Icons.person_2_outlined,
                  borderColor: defaultColor,
                  iconColor: secondaryColor,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "error_first_name ".tr(context);
                    } else {}
                  },
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultText(
                    text: 'last_name'.tr(context),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                CustomTextFormFiled(
                  controller: lastNameStudentController,
                  type: TextInputType.name,
                  prefix: Icons.person_2_outlined,
                  borderColor: defaultColor,
                  iconColor: secondaryColor,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "error_last_name".tr(context);
                    } else {}
                  },
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultText(
                    text: 'phone'.tr(context),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                CustomTextFormFiled(
                  controller: phoneNumberStudentController,
                  type: TextInputType.number,
                  prefix: Icons.phone_outlined,
                  borderColor: defaultColor,
                  iconColor: secondaryColor,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "error_phone".tr(context);
                    } else {}
                  },
                ),
                SizedBox(height: 15),
                DefFlutterRadioGroup(
                  radiokey: radiokey,
                  titles: genders(context),
                  label: 'gender'.tr(context),
                  titleStyle: Theme.of(context).textTheme.bodyLarge,
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  onChanged: (value) {
                    _selectedGender = genders(context).elementAt(value!);
                    print(genders(context).elementAtOrNull(value));
                  },
                  orientation: RGOrientation.HORIZONTAL,
                ),
                DatePicked(),
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
                        navigateAndFinish(context, VerificationScreen(isLengthCode: true,registerEmail: email,requestCodeEmail: '',));
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
                          context.read<StudentCubit>().studentRegister(
                            email: email,
                            password: password,
                            confirmPassword: confirmPassword,
                            firstName: firstNameStudentController.text,
                            lastName: lastNameStudentController.text,
                            phoneNumber: phoneNumberStudentController.text,
                            gender: _selectedGender,
                            birthday: selectDate,
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
      ),
    );
  }
}
