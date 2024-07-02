import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Introduction',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Welcome to BedMyWay. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application. Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the application.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),
            const Text(
              'Information We Collect',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We may collect information about you in a variety of ways. The information we may collect via the Application includes:',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Personal Data',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Personally identifiable information, such as your name, shipping address, email address, and telephone number, and demographic information, such as your age, gender, hometown, and interests, that you voluntarily give to us when you register with the Application or when you choose to participate in various activities related to the Application.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            const Text(
              '2. Derivative Data',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Information our servers automatically collect when you access the Application, such as your native actions that are integral to the Application, including liking, re-blogging, or replying to a post, as well as other interactions with the Application and other users via server log files.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            const Text(
              '3. Mobile Device Access',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We may request access or permission to certain features from your mobile device, including your mobile device’s calendar, camera, contacts, reminders, sensors, SMS messages, social media accounts, storage, and other features. If you wish to change our access or permissions, you may do so in your device’s settings.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),
            const Text(
              'Use of Your Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Having accurate information about you permits us to provide you with a smooth, efficient, and customized experience. Specifically, we may use information collected about you via the Application to:',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Create and manage your account.',
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              '2. Email you regarding your account or order.',
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              '3. Fulfill and manage purchases, orders, payments, and other transactions related to the Application.',
              style: TextStyle(fontSize: 12),
            ),
            // Continue adding sections as needed...
            const SizedBox(height: 16),
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'If you have questions or comments about this Privacy Policy, please contact us at:',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                _launchEmail();
              },
              child: Row(
                children: [
                  Text('Email : '),
                  Text(
                    'BedMyWay@gmail.com',
                    style: TextStyle(fontSize: 12, color: Appcolor.blue),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'BedMyWay@gmail.com',
      query:
          'subject=Account Issue&body=Please describe the issue you are experiencing with your account:', // add subject and body here
    );
    final url = params.toString();
    if (await launchUrl(Uri.parse(url))) {
    } else {
      throw 'Could not launch $url';
    }
  }
}
