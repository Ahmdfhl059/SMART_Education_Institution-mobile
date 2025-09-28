import 'package:SMART/logic/scholarship/scholarship_cubit.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';

var _radiokeyAcademicStage = GlobalKey<FlutterRadioGroupState>();
var _radiokeyTest = GlobalKey<FlutterRadioGroupState>();
var _radiokeyLanguageLevel = GlobalKey<FlutterRadioGroupState>();
var _nameSchoolController = TextEditingController();
var _specializationController = TextEditingController();
var _academicYearController = TextEditingController();
var _averageController = TextEditingController();
var _academicStage = '';
var _testLanguage = '';
var _languageLevel = '';

void showBottomSheetRegisterScholarship(BuildContext context, int scholarshipId) {
  showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    sheetAnimationStyle: AnimationStyle(
      duration: Duration(seconds: 2),
      curve: FlippedCurve(Curves.decelerate),
    ),
    showDragHandle: true,
    context: context,
    builder: (BuildContext context) => SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                text: 'Consultation Session Request From(Free).',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 15),
              DefContainer(
                child: DefFlutterRadioGroup(
                  radiokey: _radiokeyAcademicStage,
                  titles: academicStage,
                  label: 'Academic stage',
                  titleStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onChanged: (value) {
                    _academicStage = academicStage.elementAtOrNull(value!)!;
                    print(_academicStage);
                  },
                  orientation: RGOrientation.VERTICAL,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                child: DefaultText(
                  text: 'Name of school/institute/university',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              CustomTextFormFiled(
                controller: _nameSchoolController,
                type: TextInputType.name,
                prefix: Icons.account_balance_outlined,
                borderColor: defaultColor,
                iconColor: secondaryColor,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "This question is required";
                  } else {}
                },
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                child: DefaultText(
                  text: 'Field and specialization of study',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              CustomTextFormFiled(
                controller: _specializationController,
                type: TextInputType.name,
                prefix: Icons.work_outline,
                borderColor: defaultColor,
                iconColor: secondaryColor,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "This question is required ";
                  } else {}
                },
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                child: DefaultText(
                  text: 'Academic year',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              CustomTextFormFiled(
                controller: _academicYearController,
                type: TextInputType.name,
                prefix: Icons.info_outline,
                borderColor: defaultColor,
                iconColor: secondaryColor,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "This question is required";
                  } else {}
                },
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                child: DefaultText(
                  text: 'Average if the certificate is obtained',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              CustomTextFormFiled(
                controller: _averageController,
                type: TextInputType.name,
                prefix: Icons.rate_review_outlined,
                borderColor: defaultColor,
                iconColor: secondaryColor,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "This question is required";
                  } else {}
                },
              ),
              SizedBox(height: 15),
              DefContainer(
                child: DefFlutterRadioGroup(
                  radiokey: _radiokeyTest,
                  titles: test,
                  label:
                      'Have you taken a placement test or english language courses within last three month ?',
                  titleStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onChanged: (value) {
                    _testLanguage = test.elementAtOrNull(value!)!;
                    print(_testLanguage);
                  },
                  orientation: RGOrientation.VERTICAL,
                ),
              ),
              SizedBox(height: 15),
              DefContainer(
                child: DefFlutterRadioGroup(
                  radiokey: _radiokeyLanguageLevel,
                  titles: level,
                  label: 'Language level',
                  titleStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onChanged: (value) {
                    _languageLevel = level.elementAtOrNull(value!)!;
                    print(_languageLevel);
                  },
                  orientation: RGOrientation.VERTICAL,
                ),
              ),
              SizedBox(height: 15),
              DefaultButton(
                background: defaultColor,
                text: 'Register',
                onPress: () {
                  context.read<ScholarshipsCubit>().registerScholarship(
                    scholarshipId: scholarshipId,
                    academicStage: _academicStage,
                    schoolName: _nameSchoolController.text,
                    fieldOfStudy: _specializationController.text,
                    academicYear: _academicYearController.text,
                    average: _averageController.text,
                    placementTest: _testLanguage,
                    languageLevel: _languageLevel,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
