import 'dart:async';

import 'package:SMART/data/notifications/fcm_token_handler.dart' as SecureStorage;
import 'package:SMART/layout/layout.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/utils/constants.dart';
import 'package:SMART/view/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      final token = await SecureStorage.getToken();
      token.isEmpty
          ? navigateAndFinish(context, LoginScreen())
          : navigateAndFinish(context, Layout());
    });
  }
  // if (isInternet && token.isNotEmpty) {
  // navigateAndFinish(context, Layout());
  // } else if (!isInternet && token.isNotEmpty) {
  // navigateAndFinish(context, HomePage());
  // } else if (isInternet && token.isEmpty) {
  // navigateAndFinish(context, Layout());
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      body: Center(
        child: Image.asset(
          'assets/images/SMART_wight.png',
          fit: BoxFit.cover,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
