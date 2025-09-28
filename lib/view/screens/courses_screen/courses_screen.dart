import 'package:SMART/shared/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/course_cubit/course_cubit.dart';
import '../../../logic/course_cubit/course_state.dart';
import '../../../logic/levels_request/levels_requests_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../utils/constants.dart';
import '../settings_screen/settings_screen.dart';
import 'build_courses_items.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        toolbarHeight: 65,
        backgroundColor: defaultColor,
        title: DefaultText(
          text: 'Courses'.tr(context),
          style: Theme
              .of(context)
              .textTheme
              .headlineLarge,
        ),
        actions: [
          DefaultIconButton(
            onPressed: () {
              navigateTo(context, SettingsScreen());
            },
            icon: Icon(Icons.settings_outlined),
            color: Colors.white,
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 10),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              text: 'my_courses'.tr(context),
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme
                    .of(context)
                    .cardColor,
              ),
              child: SizedBox(
                height: 130,
                child: BlocBuilder<LevelsRequestsCubit, LevelsRequestsState>(
                  builder: (context, state) {
                    if (state.status == LevelsRequestsStatus.loading) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: CircularProgressIndicator(color: defaultColor),
                        ),
                      );
                    }
                    if (state.status == LevelsRequestsStatus.error) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          state.error.isEmpty
                              ? 'Error loading levels request'
                              : state.error,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildMyCourseItems(
                            context,
                            state.levelsRequests[index],
                          ),
                      itemCount: state.levelsRequests.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 10),
                    );
                  },
                ),
              ),
            ),
            DefaultText(
              text: 'Courses'.tr(context),
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
            ),
            BlocBuilder<CoursesCubit, CoursesState>(
              builder: (context, state) {
                if (state.status == CoursesStatus.loading) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: CircularProgressIndicator(color: defaultColor),
                    ),
                  );
                }
                if (state.status == CoursesStatus.error) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.error.isEmpty
                          ? 'Error loading courses'
                          : state.error,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildCourseItems(context, state.courses[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 5, width: double.infinity),
                  itemCount: state.courses.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
