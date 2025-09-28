import 'package:SMART/data/models/level_request.dart';
import 'package:SMART/utils/constants.dart';
import 'package:SMART/view/screens/courses_screen/my_request_courses.dart';
import 'package:flutter/material.dart';

import '../../../data/models/course.dart';
import '../../../shared/components/components.dart';
import '../levels_screen/view_levels_screen.dart';

Widget buildCourseItems(BuildContext context, Course courses) {
  return InkWell(
    onTap: () {
      navigateTo(context, ViewLevelsScreen(course: courses));
    },
    borderRadius: BorderRadius.circular(15),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      width: double.infinity,
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
                image: NetworkImage(courses.imageUrl),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: courses.name,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                DefaultText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: courses.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildMyCourseItems(BuildContext context, LevelRequest levelsRequest) {
  String url = "$ip/storage/${levelsRequest.imageUrl}";
  print(url);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      InkWell(
        onTap: (){
          navigateTo(context, MyRequestCourses(levelRequest: levelsRequest, image: url,));
        },
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            image: DecorationImage(image: NetworkImage(url)),
          ),
          child: Stack(
            alignment: AlignmentGeometry.directional(0.9, 0.9),
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: levelsRequest.status == 'accepted'
                      ? Colors.green
                      : levelsRequest.status == 'pending'
                      ? Colors.amber
                      : Colors.red,
                  border: BoxBorder.fromBorderSide(
                    BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                child: levelsRequest.status == 'accepted'
                    ? Icon(Icons.check, color: Colors.white, size: 15)
                    : levelsRequest.status == 'pending'
                    ? Icon(Icons.question_mark_sharp, color: Colors.white, size: 15)
                    : Icon(Icons.close_outlined, color: Colors.white, size: 15),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 5),
      SizedBox(
        width: 70,
        child: DefaultText(
          text: levelsRequest.levelName,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    ],
  );
}
