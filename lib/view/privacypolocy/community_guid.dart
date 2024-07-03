import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter/material.dart';

class CommunityGuidelinesPage extends StatelessWidget {
  const CommunityGuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Guidelines'),
        backgroundColor: Appcolor.white, // Replace with your primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'Community Guidelines',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to our community! To ensure a positive experience for everyone, please adhere to the following guidelines:',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 16),
            Text(
              '1. Be Respectful',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Treat others with respect. Harassment, discrimination, and hate speech are not tolerated.',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 16),
            Text(
              '2. No Spam',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Avoid posting repetitive or irrelevant content. Spam and advertising are prohibited.',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 16),
            Text(
              '3. Keep it Safe',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Do not share personal information or engage in unsafe behavior.',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 16),
            Text(
              '4. Report Violations',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you see someone violating these guidelines, please report it to us.',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 16),
            Text(
              '5. Follow the Law',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Abide by all applicable laws and regulations while using our app.',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 16),
            Text(
              'Thank you for being a part of our community and helping us create a safe and enjoyable environment for everyone.',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
