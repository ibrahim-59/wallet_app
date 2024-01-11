import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/views/screens/home_screen.dart';
import 'package:wallet_app/views/screens/on_boarding.dart';

goToNext({required BuildContext context}) async {
  final prefs = await SharedPreferences.getInstance();
  bool route = prefs.getBool('root') ?? false;
  Timer(const Duration(seconds: 2), () {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: route == true ? const HomeScreen() : const OnBoarding(),
            type: PageTransitionType.rightToLeft));
  });
}
