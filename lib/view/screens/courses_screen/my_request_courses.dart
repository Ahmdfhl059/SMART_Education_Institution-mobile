import 'package:SMART/data/models/level_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../utils/constants.dart';

class MyRequestCourses extends StatelessWidget {
  final String image;
  final LevelRequest levelRequest;
  const MyRequestCourses({super.key,required this.levelRequest,required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 65,
        backgroundColor: defaultColor,
        title: DefaultText(text: 'My Request', style: Theme.of(context).textTheme.headlineLarge,),
        iconTheme: IconThemeData(color: Colors.white,size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(image),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    text: levelRequest.courseName,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  DefaultText(
                    text: levelRequest.levelName,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsetsGeometry.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:Theme.of(context).cardColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultListTile(
                    textTitle: 'Time',
                    textSubTitle: levelRequest.time,
                    leading: Icon(Icons.access_time_outlined), isSubTitle: true,
                  ),
                  SizedBox(height: 15),
                  DefaultListTile(
                    textTitle: 'Status',
                    textSubTitle: levelRequest.status,
                    leading:  Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: levelRequest.status == 'accepted'
                            ? Colors.green
                            : levelRequest.status == 'pending'
                            ? Colors.amber
                            : Colors.red,
                        border: BoxBorder.fromBorderSide(
                          BorderSide(width: 2, color: Colors.white),
                        ),
                      ),
                      child: levelRequest.status == 'accepted'
                          ? Icon(Icons.check, color: Colors.white, size: 15)
                          : levelRequest.status == 'pending'
                          ? Icon(Icons.question_mark_sharp, color: Colors.white, size: 15)
                          : Icon(Icons.close_outlined, color: Colors.white, size: 15),
                    ), isSubTitle: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
