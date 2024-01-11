import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wallet_app/core/const/assets_manager.dart';

class AppConstants {
  static List<PageViewModel> onBoardingList = [
    PageViewModel(
      title: "Add all your Budget",
      bodyWidget: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "You can withdraw and deposit, and you can also see today's budget",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      image: Center(
          child: Image.asset(
        AssetsManager.onBoardingImage1,
      )),
    ),
    PageViewModel(
      title: "See All Transaction",
      bodyWidget: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "You can view all withdrawals and additions by day, week, and month",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      image: Center(
          child: Image.asset(
        AssetsManager.onBoardingImage2,
      )),
    ),
  ];
}
