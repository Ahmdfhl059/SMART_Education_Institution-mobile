import 'package:SMART/data/api/student_api.dart';
import 'package:SMART/data/repo/student_repo.dart';
import 'package:SMART/logic/auth_cubit/student_cubit.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/utils/constants.dart';
import 'package:SMART/view/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
var firstNameController = TextEditingController();
var lastNameController = TextEditingController();
var phoneController =  TextEditingController();
var emailController = TextEditingController();
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => StudentCubit(studentRepo: StudentRepo(StudentApi())),
  child: BlocConsumer<StudentCubit, StudentState>(
      listener: (context, state) {
        if (state.status == StudentStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state.status == StudentStatus.loaded) {
        //  context.read<StudentCubit>().showStudentProfile();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 12,
            toolbarHeight: 65,
            backgroundColor: defaultColor,
            title: DefaultText(
              text: 'Profile'.tr(context),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            actions: [
              DefaultIconButton(
                onPressed: () async {
                  await navigateTo(
                    context,
                    BlocProvider.value(
                      value: context.read<StudentCubit>(),
                      child: EditProfileScreen(
                        student: state.student,
                      ),
                    ),
                  );
                },
        
                icon: Icon(Icons.mode_edit_sharp),
                color: Colors.white,
              ),
            ],
            actionsPadding: EdgeInsets.only(right: 10),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment(0, 6),
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadiusGeometry.vertical(
                          bottom: Radius.circular(300),
                        ),
                      ),
                    ),
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(100),
                        border: Border.all(width: 3, color: secondaryColor),
                        image: DecorationImage(
                          image:
                              state.student.imageUrl == null ||
                                  state.student.imageUrl!.isEmpty
                              ? AssetImage('assets/images/1.jpg')
                                    as ImageProvider
                              : NetworkImage(state.student.imageUrl!),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultText(
                          text: 'first_name'.tr(context),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      CustomTextFormFiled(
                        readOnly: true,
                        hintText: state.student.firstName,
                        controller: firstNameController,
                        type: TextInputType.name,
                        prefix: Icons.person_2_outlined,
                        borderColor: defaultColor,
                        iconColor: secondaryColor,
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
                        readOnly: true,
                        hintText: state.student.lastName ,
                        controller: lastNameController,
                        type: TextInputType.name,
                        prefix: Icons.person_2_outlined,
                        borderColor: defaultColor,
                        iconColor: secondaryColor,
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
                        readOnly: true,
                        hintText: state.student.phoneNumber ,
                        controller: phoneController,
                        type: TextInputType.number,
                        prefix: Icons.phone_outlined,
                        borderColor: defaultColor,
                        iconColor: secondaryColor,
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultText(
                          text: 'birthday'.tr(context),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.fromBorderSide(
                            BorderSide(color: defaultColor),
                          ),
                        ),
                        child: DefaultText(
                          text: state.student.birthday,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
);
  }
}
