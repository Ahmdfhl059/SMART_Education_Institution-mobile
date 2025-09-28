import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';

import '../../../logic/level_cubit/level_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../utils/constants.dart';

var radiokeyAcademicStage = GlobalKey<FlutterRadioGroupState>();
var radiokeyLanguageLevel = GlobalKey<FlutterRadioGroupState>();
var radiokeySession = GlobalKey<FlutterRadioGroupState>();
var radiokeyTime = GlobalKey<FlutterRadioGroupState>();
var radiokeyDays = GlobalKey<FlutterRadioGroupState>();


var _selectedAcademicStage = '';
var _selectedLanguageLevel = '';
var _selectedTime = '';
var _selectedDays = '';
var _selectedLearningMethod = '';

void showBottomSheetRegisterCourse(BuildContext context, int levelId) {
  showModalBottomSheet(
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
              DefContainer(
                child: DefFlutterRadioGroup(
                  radiokey: radiokeyAcademicStage,
                  titles: academicStage,
                  label: 'Academic stage',
                  titleStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onChanged: (value) {
                    _selectedAcademicStage = academicStage.elementAtOrNull(
                      value!,
                    )!;
                    print(_selectedAcademicStage);
                  },
                  orientation: RGOrientation.VERTICAL,
                ),
              ),
              SizedBox(height: 15),
              DefContainer(
                child: DefFlutterRadioGroup(
                  radiokey: radiokeyLanguageLevel,
                  titles: level,
                  label: 'Language level',
                  titleStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onChanged: (value) {
                    _selectedLanguageLevel = level.elementAtOrNull(value!)!;
                    print(_selectedLanguageLevel);
                  },
                  orientation: RGOrientation.VERTICAL,
                ),
              ),
              SizedBox(height: 15),
              DefContainer(
                child: DefFlutterRadioGroup(
                  radiokey: radiokeyTime,
                  titles: time,
                  label: 'Time',
                  titleStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onChanged: (value) {
                    _selectedTime = time.elementAtOrNull(value!)!;
                    print(_selectedTime);
                  },
                  orientation: RGOrientation.HORIZONTAL,
                ),
              ),
              SizedBox(height: 15),
              DefContainer(
                child: DefFlutterRadioGroup(
                  radiokey: radiokeyDays,
                  titles: days,
                  label: 'Days',
                  titleStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onChanged: (value) {
                    _selectedDays = days.elementAtOrNull(value!)!;
                    print(_selectedDays);
                  },
                  orientation: RGOrientation.HORIZONTAL,
                ),
              ),
              SizedBox(height: 15),
              DefContainer(
                child: DefFlutterRadioGroup(
                  radiokey: radiokeySession,
                  titles: session,
                  label: 'The way of attending the course',
                  titleStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onChanged: (value) {
                    _selectedLearningMethod = session.elementAtOrNull(value!)!;
                    print(_selectedLearningMethod);
                  },
                  orientation: RGOrientation.VERTICAL,
                ),
              ),
              SizedBox(height: 15),
              DefaultButton(
                background: defaultColor,
                text: 'Register',
                onPress: () {
                  context.read<LevelCubit>().registerLevel(
                    levelId: levelId,
                    academicStage: _selectedAcademicStage,
                    languageLevel: _selectedLanguageLevel,
                    time: _selectedTime,
                    days: _selectedDays,
                    learningMethod: _selectedLearningMethod,

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
