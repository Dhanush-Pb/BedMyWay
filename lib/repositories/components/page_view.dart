// ignore_for_file: prefer_const_constructors

import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onNextPressed; // Callback for the next button
  final String skipText;
  final String previousText;
  final VoidCallback onPreviousPressed;
  final String? beforetitle;
  OnboardingPage({
    required this.beforetitle,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onNextPressed,
    required this.skipText,
    required this.previousText,
    required this.onPreviousPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Pre-caching the image during initialization
    precacheImage(AssetImage(imagePath), context);

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  height: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            beforetitle ?? '',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Appcolor.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 24,
                                color: Appcolor.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: TextStyle(color: Appcolor.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 310,
                right: 0,
                child: TextButton(
                  onPressed: onNextPressed,
                  child: Text(
                    'Next >>', // Change the text here

                    style: TextStyle(fontSize: 14, color: Appcolor.blue),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 310,
                right: 0,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const Logingpage(),
                        transitionDuration: const Duration(milliseconds: 500),
                        transitionsBuilder:
                            (context, animation1, animation2, child) {
                          return FadeTransition(
                            opacity: animation1,
                            child: child,
                          );
                        },
                      ),
                    ); // Add action for skipping
                  },
                  child: Text(
                    skipText, // Change the text here
                    style: TextStyle(
                        color: Appcolor.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 310,
                child: TextButton(
                  onPressed: onPreviousPressed,
                  child: Text(
                    previousText, // Change the text here
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Appcolor.red),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
