// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionChecker {
  static StreamSubscription? internetConnectionSubscription;

  static void start(BuildContext context) {
    final internetConnectionChecker =
        InternetConnectionCheckerPlus.createInstance();

    internetConnectionSubscription = internetConnectionChecker.onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('CONNECTED');
          break;
        case InternetConnectionStatus.disconnected:
          print('DISCONNECTED');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'No internet connection',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text('Please try again later'),
                ],
              ),
              duration: const Duration(seconds: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor:
                  Appcolor.shimer1, 
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05,
                horizontal: MediaQuery.of(context).size.width * 0.22,
              ),
            ),
          );
          break;
      }
    });
  }

  static void stop() {
    internetConnectionSubscription?.cancel();
  }
}
