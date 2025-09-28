import 'package:SMART/data/models/level_request.dart';
import 'package:SMART/data/models/scholarship.dart';
import 'package:SMART/data/models/scholarship_request%20.dart';
import 'package:SMART/logic/scholarship/scholarship_cubit.dart';
import 'package:SMART/logic/scholarship/scholarship_state.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/view/screens/description_scholarship_screen/description_scholarship_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import 'my_request_scholarship.dart';

Widget buildScholarshipItems(BuildContext context,Scholarship scholarships,) {

  return BlocBuilder<ScholarshipsCubit, ScholarshipsState>(
    builder: (context, state) {
      return InkWell(
        onTap: () {
          navigateTo(
            context,
            DescriptionScholarshipScreen(scholarship: scholarships,),
          );
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
                    image: NetworkImage(scholarships.imageUrl),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: scholarships.name,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    DefaultText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: scholarships.desc,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
Widget buildMyScholarshipItems(BuildContext context, LevelRequest scholarshipRequest) {
  String url = "$ip/storage/${scholarshipRequest.imageUrl}";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      InkWell(
        onTap: (){
          navigateTo(context, MyRequestScholarship(image: url, scholarshipRequest: scholarshipRequest,));
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
                  color: scholarshipRequest.status == 'accepted'
                      ? Colors.green
                      : scholarshipRequest.status == 'pending'
                      ? Colors.amber
                      : Colors.red,
                  border: BoxBorder.fromBorderSide(
                    BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                child: scholarshipRequest.status == 'accepted'
                    ? Icon(Icons.check, color: Colors.white, size: 15)
                    : scholarshipRequest.status == 'pending'
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
          text: scholarshipRequest.levelName,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    ],
  );
}