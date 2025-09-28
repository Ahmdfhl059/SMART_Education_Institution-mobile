import 'package:SMART/data/models/scholarship.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/utils/constants.dart';
import 'package:flutter/material.dart';

import 'build_bottom_sheet_register_scholarship.dart';

class DescriptionScholarshipScreen extends StatelessWidget {
  final Scholarship scholarship;
  const DescriptionScholarshipScreen({super.key, required this.scholarship });

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
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(scholarship.imageUrl),
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
                      text: scholarship.name,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    DefaultText(
                      text: scholarship.desc,
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
                      textTitle: 'Country',
                      textSubTitle: scholarship.country,
                      leading: Icon(Icons.public_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'University',
                      textSubTitle: scholarship.university,
                      leading: Icon(Icons.account_balance_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Specialization',
                      textSubTitle: scholarship.specialization,
                      leading: Icon(Icons.work_outline), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Funding Agency',
                      textSubTitle: scholarship.fundingAgency,
                      leading: Icon(Icons.business_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Type Of Financing',
                      textSubTitle: scholarship.typeOfFinancing,
                      leading: Icon(Icons.wallet_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Advantages',
                      textSubTitle: scholarship.advantages,
                      leading: Icon(Icons.star_border_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Achieved Certificate',
                      textSubTitle: scholarship.achievedCertificate,
                      leading: Icon(Icons.emoji_events_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Required Documents',
                      textSubTitle: scholarship.requiredDocuments,
                      leading: Icon(Icons.library_books_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Required Certificates',
                      textSubTitle: scholarship.requiredCertificates,
                      leading: Icon(Icons.school_outlined), isSubTitle: true,
                    ),
                    SizedBox(height: 15),
                    DefaultListTile(
                      textTitle: 'Submission Time',
                      textSubTitle: scholarship.submissionTime,
                      leading: Icon(Icons.date_range_outlined), isSubTitle: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              DefaultButton(
                background: defaultColor,
                text: 'Join Now',
                onPress: () {
                  showBottomSheetRegisterScholarship(context,scholarship.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

