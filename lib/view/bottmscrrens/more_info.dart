import 'dart:ui';

import 'package:bedmyway/Model/goolgle_map.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/components/bottm_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MoreInfoPage extends StatefulWidget {
  final List<dynamic> TourImages;
  final String adreess;
  final String touristdetails;
  final String contact;
  final String hotelname;
  final String location;
  final List<dynamic> roomImages;
  final String messageDirection;

  const MoreInfoPage({
    Key? key,
    required this.TourImages,
    required this.adreess,
    required this.touristdetails,
    required this.hotelname,
    required this.roomImages,
    required this.location,
    required this.contact,
    required this.messageDirection,
  }) : super(key: key);

  @override
  State<MoreInfoPage> createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  bool showtourimage = false;
  int _currentindexT = 0;

  @override
  Widget build(BuildContext context) {
    List<String> validTourImages =
        widget.TourImages.where((image) => image != null)
            .map<String>((image) => image as String)
            .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const NavigationMenu()));
            },
            icon: const Icon(Icons.close_outlined),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Appcolor.red,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    height: 150,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.hotelname,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: Appcolor.white,
                          ),
                        ),
                        Text(
                          widget.location,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Appcolor.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                openMap(
                                    hotelname: widget.hotelname,
                                    loc: widget.location,
                                    address: widget.adreess);
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 30,
                                  ),
                                  SizedBox(width: 5),
                                  Text('Direction'),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                makeCall(widget.contact);
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 30,
                                  ),
                                  SizedBox(width: 5),
                                  Text('Call'),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                // Handle message
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.message_outlined,
                                    size: 30,
                                  ),
                                  SizedBox(width: 5),
                                  Text('Message'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Address',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Appcolor.red2,
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(widget.adreess),
                            const SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Must See Sights',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showtourimage = !showtourimage;
                            });
                          },
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 160,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                            ),
                            items: validTourImages.map((imageUrl) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      // Image loaded successfully
                                      return child;
                                    } else {
                                      // Image still loading, display shimmer
                                      return Shimmer.fromColors(
                                        baseColor: Appcolor.shimmercolor1,
                                        highlightColor: Appcolor.Shimmercolor2,
                                        child: Container(
                                          color: Colors.white,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 160,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    // Error occurred while loading image, display shimmer
                                    return Shimmer.fromColors(
                                      baseColor: Appcolor.shimmercolor1,
                                      highlightColor: Appcolor.Shimmercolor2,
                                      child: Container(
                                        color: Colors.white,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 160,
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Explore Nearby Beauty',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Description: ${widget.touristdetails}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showtourimage)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showtourimage = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Stack(
                            children: [
                              CarouselSlider.builder(
                                itemCount: validTourImages.length,
                                itemBuilder: (BuildContext context,
                                    int itemIndex, int pageViewIndex) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      validTourImages[itemIndex],
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Shimmer.fromColors(
                                            baseColor: Appcolor.shimmercolor1!!,
                                            highlightColor:
                                                Appcolor.Shimmercolor2!,
                                            child: Container(
                                              color: Colors.white,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 160,
                                            ),
                                          );
                                        }
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Shimmer.fromColors(
                                          baseColor: Appcolor.shimmercolor1!!,
                                          highlightColor:
                                              Appcolor.Shimmercolor2!,
                                          child: Container(
                                            color: Appcolor.white,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 160,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  viewportFraction: 1.0,
                                  initialPage: _currentindexT,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentindexT = index;
                                    });
                                  },
                                ),
                              ),
                              Positioned(
                                top: 18,
                                right: 20,
                                child: IconButton(
                                  highlightColor: Appcolor.red,
                                  icon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      showtourimage = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              validTourImages.asMap().entries.map((entry) {
                            int index = entry.key;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              height: 8.0,
                              width: _currentindexT == index ? 23.0 : 8.0,
                              decoration: BoxDecoration(
                                color: _currentindexT == index
                                    ? Appcolor.red
                                    : const Color.fromARGB(255, 194, 194, 194),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Text(
                        '${_currentindexT + 1}/${validTourImages.length}',
                        style: TextStyle(
                            color: Appcolor.white, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
