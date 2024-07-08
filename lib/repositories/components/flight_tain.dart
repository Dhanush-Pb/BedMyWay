// ignore_for_file: prefer_const_constructors

import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainPlane extends StatelessWidget {
  const TrainPlane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            'Book your transportation',
            style: TextStyle(
              color: Appcolor.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Appcolor.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                iconSize: 30,
                onPressed: () {
                  launchUrl(Uri.parse('https://www.irctc.co.in/'));
                },
                icon: const Icon(Icons.train),
                color: Appcolor.red2,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Appcolor.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                iconSize: 30,
                onPressed: () {
                  launchUrl(Uri.parse('https://www.goindigo.in/'));
                },
                icon: const Icon(Icons.flight),
                color: Appcolor.red2,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Appcolor.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                iconSize: 30,
                onPressed: () {
                  launchUrl(Uri.parse('https://www.uber.com/in/en/'));
                },
                icon: const Icon(Icons.local_taxi_outlined),
                color: Appcolor.red2,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Appcolor.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                iconSize: 30,
                onPressed: () {
                  launchUrl(Uri.parse('https://www.redbus.in/'));
                },
                icon: Icon(
                  FontAwesomeIcons.bus,
                  size: 25,
                ),
                color: Appcolor.red2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1.5,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 120,
                // enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.easeInOutSine,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                viewportFraction: 1,
              ),
              items: [
                'assets/images/1044047240-1044047239_dom-banner-994x415jpg.jpg',
                'assets/images/Advantages-of-Expanding-Your-On-Demand-Taxi-Booking-Startup-and-Steps-to-Follow-to-Make-It-Successful-2.png',
                'assets/images/Best-Bus-Booking-Apps-India-min.jpg',
                'assets/images/banner_2n.jpg',
              ].map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
