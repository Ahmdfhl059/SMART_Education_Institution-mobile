import 'package:SMART/data/models/student.dart';
import 'package:SMART/logic/auth_cubit/student_cubit.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/utils/constants.dart';
import 'package:SMART/view/screens/edit_profile_screen/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

var formKey = GlobalKey<FormState>();

class EditProfileScreen extends StatelessWidget {
  final Student student;

  const EditProfileScreen({super.key, required this.student});
  @override
  Widget build(BuildContext context) {
    var editProfileFirstNameController = TextEditingController(
      text:student.firstName,
    );
    var editProfileLastNameController = TextEditingController(
      text: student.lastName,
    );
    var editProfilePhoneController = TextEditingController(
      text: student.phoneNumber,
    );
    selectDate = student.birthday;
    XFile? image;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  titleSpacing: 0,
                  toolbarHeight: 65,
                  iconTheme: IconThemeData(color: Colors.white, size: 30),
                  title: DefaultText(
                    text: 'Edit_Profile'.tr(context),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  backgroundColor: defaultColor,
                  actions: [
                    BlocConsumer<StudentCubit, StudentState>(
                      listener: (context, state) {
                        if (state.status == StudentStatus.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        } else if (state.status == StudentStatus.loaded) {
                          navigatePop(context, true);
                        }
                      },
                      builder: (context, state) {
                        return DefaultIconButton(
                          onPressed: () {
                            context.read<StudentCubit>().updateStudentProfile(
                              firstName: editProfileFirstNameController.text,
                              lastName: editProfileLastNameController.text,
                              phoneNumber: editProfilePhoneController.text,
                              birthday: selectDate,
                              image: image,
                            );
                          },
                          icon: Icon(Icons.check_rounded),
                          color: Colors.white,
                          size: 35,
                        );
                      },
                    ),
                  ],
                  expandedHeight: 20,
                ),
              ],
            ),
            ProfileImagePicker(
              initialImage: image,
              onImageSelected: (selectedImage) {
                  image = selectedImage;
              },
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
                    controller: editProfileFirstNameController,
                    type: TextInputType.name,
                    prefix: Icons.person_2_outlined,
                    borderColor: defaultColor,
                    iconColor: secondaryColor,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "error_first_name".tr(context);
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
                    controller: editProfileLastNameController,
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
                    controller: editProfilePhoneController,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DefaultText(
                      text: 'birthday'.tr(context),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  DatePicked(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
