import 'package:SMART/data/models/level_request.dart';
import 'package:SMART/data/models/scholarship_request%20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../utils/constants.dart';

class MyRequestScholarship extends StatelessWidget {
  final String image;
  final LevelRequest scholarshipRequest;
  const MyRequestScholarship({super.key, required this.image, required this.scholarshipRequest});

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
                    text: scholarshipRequest.levelName,
                    style: Theme.of(context).textTheme.displayLarge,
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
                    textTitle: 'Status',
                    textSubTitle: scholarshipRequest.status,
                    leading:  Container(
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
