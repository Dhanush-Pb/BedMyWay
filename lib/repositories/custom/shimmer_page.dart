// ignore_for_file: use_key_in_widget_constructors

import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerClass extends StatelessWidget {
  const ShimmerClass({Key? key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Appcolor.shimmercolor1,
          highlightColor: Appcolor.Shimmercolor2,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            leading: Container(
              decoration: BoxDecoration(
                color: Appcolor.grey,
                shape: BoxShape.circle,
              ),
              height: 120,
              width: screenWidth * 0.2,
            ),
            title: Container(
              decoration: BoxDecoration(
                color: Appcolor.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 13,
              width: screenWidth * 0.3,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Appcolor.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 12,
                  width: screenWidth * 0.6,
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Appcolor.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 9,
                  width: screenWidth * 0.4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
