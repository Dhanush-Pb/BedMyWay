import 'package:bedmyway/Model/goolgle_map.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Help Center',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'We are here to assist you with any questions or issues you may have regarding our hotel booking app. Below are some common topics that might help you:',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),
            _buildHelpItem(
              context,
              'How to Book a Hotel',
              'Learn how to search for hotels, select dates, and complete your booking.',
            ),
            _buildHelpItem(
              context,
              'Account Management',
              'Information about creating an account,and managing bookings.',
            ),
            _buildHelpItem(
              context,
              'Cancellation Policy',
              'Understand our policies regarding cancellations and refunds.',
            ),
            _buildHelpItem(
              context,
              'Contact Customer Support',
              'Need further assistance? Contact our customer support team.',
            ),
            InkWell(
              onTap: () {
                makeCall('9947191878');
              },
              child:
                  _buildHelpItem(context, 'Call', '9947191878', Appcolor.blue),
            ),
            InkWell(
              onTap: () {
                _launchEmail();
              },
              child: _buildHelpItem(
                  context, 'Email', 'dhanushpb49@gmail.com', Appcolor.blue),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(BuildContext context, String title, String description,
      [Color? color]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: color ?? Appcolor.black),
          ),
        ],
      ),
    );
  }

  void _launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'dhanushpb49@gmail.com',
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
