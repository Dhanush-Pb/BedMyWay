import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About BedMyWay',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to our hotel booking app, your ultimate tool for finding and booking accommodations worldwide. Whether you’re planning a business trip, family vacation, or weekend getaway, our app is designed to make your hotel booking experience seamless and enjoyable.',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 16),
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'At our hotel booking app, our mission is to connect travelers with the perfect accommodations that suit their needs and preferences. We strive to offer a wide range of hotels, from budget-friendly options to luxury resorts, ensuring there’s something for every traveler.',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 16),
            Text(
              'Key Features',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. Extensive Hotel Listings: Browse and choose from a diverse selection of hotels worldwide.\n'
              '2. Easy Booking Process: Book your stay with just a few taps, ensuring a hassle-free reservation experience.\n'
              '3. Detailed Information: Access comprehensive details about each hotel, including amenities, room types, and guest reviews.\n'
              '4. Flexible Search Options: Customize your search based on location, dates, price range, and more.\n'
              '5. Customer Support: Our dedicated support team is available to assist you 24/7 with any inquiries or issues.',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions, feedback, or need assistance, please feel free to reach out to us at BedMyWay@gmil.com We are committed to providing you with exceptional service and ensuring your satisfaction.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
