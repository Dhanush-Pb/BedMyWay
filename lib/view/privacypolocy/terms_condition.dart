import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to Bed My Way, your trusted hotel booking application. Please read the following terms and conditions carefully before using our services.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 16),
              Text(
                '1. Introduction',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'These terms and conditions govern your use of our application. By using Bed My Way, you agree to comply with these terms.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 16),
              Text(
                '2. Booking Policy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'All bookings made through Bed My Way are subject to availability and confirmation from the respective hotel. We strive to provide accurate information, but we are not responsible for any discrepancies.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 16),
              Text(
                '3. Payment Policy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Payments for bookings must be made using the methods specified on our platform. Please ensure that you provide accurate payment information to avoid any delays or issues.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 16),
              Text(
                '4. Cancellation and Refund Policy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Cancellation policies vary by hotel and booking type. Please review the specific cancellation policy associated with your booking. Note that some hotels have a no refund policy due to financial issues, which will be clearly stated at the time of booking.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 16),
              Text(
                '5. User Responsibilities',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Users are responsible for providing accurate information during the booking process. Any false or misleading information may result in the cancellation of your booking without a refund.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 16),
              Text(
                '6. Limitation of Liability',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Bed My Way is not liable for any damages or losses arising from the use of our services, including but not limited to, direct, indirect, incidental, or consequential damages.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 16),
              Text(
                '7. Changes to Terms',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We reserve the right to modify these terms and conditions at any time. Any changes will be effective immediately upon posting on our platform. Please review these terms regularly to stay informed of any updates.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 16),
              Text(
                '8. Contact Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'If you have any questions or concerns about these terms and conditions, please contact us at support@bedmyway.com.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 16),
              Text(
                'Thank you for choosing Bed My Way for your hotel booking needs.',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
