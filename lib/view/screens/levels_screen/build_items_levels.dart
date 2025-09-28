import 'package:SMART/data/models/level.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/utils/constants.dart';
import 'package:SMART/view/screens/description_level_screen/description_level_screen.dart';
import 'package:flutter/material.dart';

Widget buildItemsLevels(BuildContext context, Level level) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: DefaultListTile(
      onTap: () {
        navigateTo(context, DescriptionLevelScreen(level: level,));
      },
      textTitle: level.name,
      textSubTitle: level.description,
      trailing: level.status == 'full'
          ? Icon(Icons.cancel_outlined, color: Colors.red)
          : level.status == 'enrolling'
          ? Icon(Icons.check_circle_outline, color: Colors.green)
          : Icon(Icons.access_time, color: secondaryColor),
      maxLinesSubTitle: 1,
      overflowSubTitle: TextOverflow.ellipsis, isSubTitle: true,
    ),
  );
}
