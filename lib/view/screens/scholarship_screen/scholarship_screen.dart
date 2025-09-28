import 'package:SMART/logic/levels_request/levels_requests_cubit.dart';
import 'package:SMART/logic/scholarship/scholarship_cubit.dart';
import 'package:SMART/logic/scholarship/scholarship_state.dart';
import 'package:SMART/logic/scholarship_request_cubit/scholarships_requests_cubit.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/utils/constants.dart';
import 'package:SMART/view/screens/scholarship_screen/build_scholarship_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings_screen/settings_screen.dart';

class ScholarshipScreen extends StatelessWidget {
  const ScholarshipScreen({super.key});

  // String _imageUrl() {
  //   Scholarship scholarship=Scholarship.initial();
  //   if (scholarship.imageUrl.isEmpty) return '';
  //   return "http://10.65.11.16:8000/storage${scholarship.imageUrl}";
  // }
  @override
  Widget build(BuildContext context) {
    //  final String image=_imageUrl();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        toolbarHeight: 65,
        backgroundColor: defaultColor,
        title: DefaultText(
          text: 'Scholarship'.tr(context),
          style: Theme.of(context).textTheme.headlineLarge,
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
              text: 'my_scholarship'.tr(context),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor,
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
                              ? 'Error loading scholarships'
                              : state.error,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildMyScholarshipItems(context,state.levelsRequests[index]),
                      itemCount: state.levelsRequests.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 10),
                    );
                  },
                ),
              ),
            ),
            DefaultText(
              text: 'scholarship'.tr(context),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            BlocBuilder<ScholarshipsCubit, ScholarshipsState>(
              builder: (context, state) {
                if (state.status == ScholarshipsStatus.loading) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: CircularProgressIndicator(color: defaultColor),
                    ),
                  );
                }
                if (state.status == ScholarshipsStatus.error) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.error.isEmpty
                          ? 'Error loading scholarships'
                          : state.error,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildScholarshipItems(context, state.scholarships[index]),
                  separatorBuilder: (BuildContext context, index) =>
                      SizedBox(height: 5, width: double.infinity),
                  itemCount: state.scholarships.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
