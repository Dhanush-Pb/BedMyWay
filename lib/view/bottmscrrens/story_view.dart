// ignore_for_file: library_private_types_in_public_api

import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/view/bottmscrrens/hotel_details.dart';
import 'package:flutter/material.dart';

class AlternateHotelImagePage extends StatefulWidget {
  final List<dynamic> coverImages;
  final List<dynamic> pathImages;
  final int currentIndex;
  final Map<String, dynamic> hotel;
  const AlternateHotelImagePage({
    Key? key,
    required this.coverImages,
    required this.pathImages,
    required this.currentIndex,
    required this.hotel,
  }) : super(key: key);

  @override
  _AlternateHotelImagePageState createState() =>
      _AlternateHotelImagePageState();
}

class _AlternateHotelImagePageState extends State<AlternateHotelImagePage> {
  late PageController _pageController;
  late int currentIndex;

  late int index = currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.coverImages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.coverImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.pathImages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.pathImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HotelDetailPage(hotel: widget.hotel)));
              },
              child: const Text('Chek now'),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
