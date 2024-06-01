import 'dart:ui';

import 'package:flutter/material.dart';

class Messegepage extends StatelessWidget {
  const Messegepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background image with blur effect
        Positioned.fill(
          child: Image.asset(
            'assets/images/ranjith-alingal-f-MvFZ6-M3U-unsplash.jpg', // Replace with your image URL
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.2), // Adjust opacity as needed
            ),
          ),
        ),
        // Your main content here
      ]),
    );
  }
}
