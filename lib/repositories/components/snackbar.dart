import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter/material.dart';

class snackbar {
  static void showErrorMessageSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Sign in error'),
              Text(
                message,
                style: TextStyle(
                  color: Appcolor.white,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Appcolor.goole,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 8, left: 60, right: 60),
        padding: const EdgeInsets.symmetric(horizontal: .0, vertical: 10),
      ),
    );
  }
}
