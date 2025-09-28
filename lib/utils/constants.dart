import 'package:SMART/shared/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';

const secureStorage = FlutterSecureStorage();
 List<String> genders(BuildContext context) => ['male'.tr(context), 'female'.tr(context)];
final List<String> academicStage = ['Pre-Secondary', 'Secondary','Institute','University Degree','Master\'s','PHD'];
final List<String> test = ['Yes', 'No'];
final List<String> level = ['Beginner', 'Weak-Elemantry','Per-Intermediate','Intermediate','Advanced Upper Intermediate','I Can\'t Decide'];
final List<String> session = ['At SMART Foundation In Damascus', 'Online'];
final List<String> time = ['18:00', '15:00', '20:00'];
final List<String> days = ['Tue-Thu-Wed', 'Sat-Sun-Mon'];
final ipAddress = "http://10.210.138.194:8000";
final baseURL = "$ipAddress/api";
final ip = "$ipAddress";

final phone='0945745858';
final facebook='https://www.facebook.com/smart.education.institution';
final instagram='https://www.instagram.com/smart_education_institution/';
final defaultColor = HexColor('#006680');
 HexColor secondaryColor = HexColor('#f0a815');

