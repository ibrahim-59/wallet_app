import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:wallet_app/core/const/assets_manager.dart';
import 'package:wallet_app/core/styles/colors.dart';
import 'package:wallet_app/core/functions/go_to_next.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToNext(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeIn(
          delay: const Duration(milliseconds: 800),
          animate: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeIn(
                  delay: const Duration(milliseconds: 800),
                  child: SvgPicture.asset(AssetsManager.log)),
              const SizedBox(
                height: 30,
              ),
              FadeIn(
                  delay: const Duration(milliseconds: 800),
                  child: Text(
                    "Wallet App",
                    style: GoogleFonts.lobster(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryGreen),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
