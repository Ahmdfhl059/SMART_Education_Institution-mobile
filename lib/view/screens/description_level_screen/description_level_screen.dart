import 'package:SMART/data/models/level.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/utils/constants.dart';
import 'package:SMART/view/screens/description_level_screen/build_bottomshet_register_level.dart';
import 'package:flutter/material.dart';


class DescriptionLevelScreen extends StatelessWidget {
  final Level level;
  const DescriptionLevelScreen({super.key, required this.level,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 65,
        backgroundColor: defaultColor,
        title: DefaultText(text: 'Description'.tr(context), style: Theme.of(context).textTheme.headlineLarge,),
        iconTheme: IconThemeData(color: Colors.white,size: 30),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                text: level.name,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              DefaultText(
                text: level.description,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsetsGeometry.all( 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultListTile(
                      textTitle: 'Start_Date'.tr(context),
                      textSubTitle: level.startAt,
                      leading: Icon(Icons.date_range_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Time'.tr(context),
                      textSubTitle: level.time,
                      leading: Icon(Icons.access_time_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Days'.tr(context),
                      textSubTitle: level.days.toString(),
                      leading: Icon(Icons.next_week_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Seats_Number'.tr(context),
                      textSubTitle: level.seatsNum.toString(),
                      leading: Icon(Icons.event_seat_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Status'.tr(context),
                      textSubTitle: level.status,
                      leading: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: level.status == 'enrolling'
                              ? Colors.green
                              : level.status == 'starting_soon'
                              ? Colors.amber
                              : Colors.red,
                          border: BoxBorder.fromBorderSide(
                            BorderSide(width: 2, color: Colors.white),
                          ),
                        ),
                        child: level.status == 'enrolling'
                            ? Icon(Icons.check, color: Colors.white, size: 15)
                            : level.status == 'starting_soon'
                            ? Icon(Icons.question_mark_sharp, color: Colors.white, size: 15)
                            : Icon(Icons.close_outlined, color: Colors.white, size: 15),
                      ), isSubTitle: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              DefaultButton(
                background:level.status == 'full' ?Colors.grey.shade600:defaultColor,
                text: level.status == 'full'?'Full':'Join_Now'.tr(context),
                onPress: () {
                  level.status == 'full'? () :showBottomSheetRegisterCourse(context,level.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}