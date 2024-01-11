// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/core/const/const.dart';
import 'package:wallet_app/core/styles/colors.dart';
import 'package:wallet_app/views/screens/home_screen.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();
                prefs.setBool("root", true);
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const HomeScreen(),
                        type: PageTransitionType.rightToLeft));
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      body: IntroductionScreen(
        pages: AppConstants.onBoardingList,
        showNextButton: true,
        next: Material(
          color: kPrimaryGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text("Next",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor,
                    fontSize: 16)),
          ),
        ),
        done: Material(
          color: kPrimaryGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text("Done",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor,
                    fontSize: 16)),
          ),
        ),
        onDone: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("root", true);
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const HomeScreen(),
                  type: PageTransitionType.rightToLeft));
        },
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          color: Colors.grey,
          activeColor: kPrimaryGreen,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }
}
