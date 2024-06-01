// ignore_for_file: non_constant_identifier_names

import 'package:bedmyway/Model/google_sing.dart';
import 'package:bedmyway/controller/bloc/auth_bloc.dart';
import 'package:bedmyway/controller/fetchbloc/bloc/hoteldata_bloc.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/custom/alertdiloge.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/view/bottmscrrens/hotel_details.dart';
import 'package:bedmyway/view/bottmscrrens/search_page.dart';
import 'package:bedmyway/view/login/login_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? currentuserr;
  int _currentIndex =
      0; // Added this line to track the current index of the carousel
  int _currentindex2 = 0;
  @override
  void initState() {
    currentuserr = FirebaseAuth.instance.currentUser;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Row(
            children: [],
          ),
          leading: PreferredSize(
            preferredSize: const Size(70,
                kToolbarHeight), // Set the preferred size for the leading widget
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<HoteldataBloc, HoteldataState>(
        builder: (context, state) {
          if (state is HoteldataLoading) {
            return Container(
              child: const CircularProgressIndicator(),
            );
          } else if (state is HotelDatafetched) {
            List<Widget> carouselItems = state.hotels.map((hotel) {
              final roomImages = hotel['images'] as List<dynamic>;
              final firstImageUrl =
                  roomImages.isNotEmpty ? roomImages.first : null;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: firstImageUrl != null
                              ? Image.network(
                                  firstImageUrl,
                                  fit: BoxFit.cover,
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel['name'] ?? 'Hotel Name',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  hotel['locaton'] ?? 'Location',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Price: \$${hotel['price'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
            List<Widget> carouselItems2 = state.hotels.map((hotel) {
              final roomImages = hotel['images'] as List<dynamic>;
              final secondImageUrl =
                  roomImages.length > 1 ? roomImages[1] : null;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: secondImageUrl != null
                              ? Image.network(
                                  secondImageUrl,
                                  fit: BoxFit.cover,
                                )
                              : Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 74, 72, 72),
                                  highlightColor:
                                      const Color.fromARGB(255, 67, 67, 67),
                                  child: Container(
                                      color: const Color.fromARGB(
                                          255, 62, 62, 62)),
                                ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 5, bottom: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                hotel['locaton'] ?? 'Location',
                                style: TextStyle(
                                  color: Appcolor.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Price: \$${hotel['price'] ?? 'N/A'}',
                                style: TextStyle(
                                  color: Appcolor.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            hotel['sinceYear'],
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList();

            final countofhotel = state.hotels.length;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 18,
                        right: 18,
                        bottom: 10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Searchpage()));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(45, 180, 180, 180),
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.search),
                              const SizedBox(width: 20),
                              Text(
                                'Search for city, location or hotel',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Appcolor.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 125,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2, right: 6),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: countofhotel,
                        itemBuilder: (context, index) {
                          final hotel = state.hotels[index];

                          final location = hotel['locaton'];
                          List<String> tourimage = [];
                          if (hotel['tourimage'] is List<dynamic>) {
                            tourimage = (hotel['tourimage'] as List<dynamic>)
                                .map((item) {
                              return item is String ? item : '';
                            }).toList();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              top: 4,
                              right: 2,
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(tourimage.last),
                                  radius: 43,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: tourimage.isNotEmpty
                                        ? NetworkImage(tourimage.first)
                                        : const AssetImage(
                                                'assets/images/default_hotel_image.png')
                                            as ImageProvider,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(location ?? 'Unknown Location'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Best offers for you',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(FadePageRoute(
                                    page: HotelDetailPage(
                                  hotel: state.hotels[_currentIndex],
                                )));
                              },
                              child: CarouselSlider(
                                items: carouselItems,
                                options: CarouselOptions(
                                    height: 200,
                                    aspectRatio: 16 / 9,
                                    autoPlay: true,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 600),
                                    viewportFraction: 0.8,
                                    pageSnapping: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    }),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: Text(
                      'Exclusive Selections',
                      style: TextStyle(
                          color: Appcolor.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(FadePageRoute(
                          page: HotelDetailPage(
                        hotel: state.hotels[_currentindex2],
                      )));
                    },
                    child: CarouselSlider(
                      items: carouselItems2,
                      options: CarouselOptions(
                          height: 300,
                          aspectRatio: 16 / 5,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 600),
                          viewportFraction: 0.6,
                          pageSnapping: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentindex2 = index;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(0, 0, 0, 0),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: currentuserr?.photoURL != null
                          ? NetworkImage(currentuserr!.photoURL!)
                          : const AssetImage(
                              'assets/images/WhatsApp Image 2024-05-29 at 16.25.58_d7bc7d41.jpg',
                            ) as ImageProvider,
                    ),
                    Text(
                      currentuserr?.displayName ??
                          currentuserr?.phoneNumber ??
                          '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      currentuserr?.email ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Appcolor.white,
                ),
                title: Text(
                  'Sign Out',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlert(
                        title: 'Logout confirmation',
                        content: 'Are you sure you want to logout?',
                        buttonText: 'Yes',
                        onPressed: () {
                          final AuthBlocs = BlocProvider.of<AuthBloc>(context);
                          AuthBlocs.add(logoutevent());
                          signOut(context);
                          Navigator.of(context).pushAndRemoveUntil(
                            FadePageRoute(page: const Logingpage()),
                            (route) => false,
                          );
                        },
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: Appcolor.white),
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  // Handle privacy policy
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Appcolor.white),
                title: Text(
                  'Help',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  // Handle help
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Appcolor.white),
                title: Text(
                  'About',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  // Handle about

                  // Handle contact us
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildShimmerCarousel() {
  //   return Shimmer.fromColors(
  //     baseColor: const Color.fromARGB(255, 0, 217, 255),
  //     highlightColor: const Color.fromARGB(255, 123, 245, 9),
  //     child: CarouselSlider.builder(
  //       itemCount: 5, // Adjust the number of shimmer items as needed
  //       itemBuilder: (BuildContext context, int index, int realIndex) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8),
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Colors.black.withOpacity(0.5),
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //           ),
  //         );
  //       },
  //       options: CarouselOptions(
  //         height: 200,
  //         aspectRatio: 16 / 9,
  //         autoPlayCurve: Curves.fastOutSlowIn,
  //         enableInfiniteScroll: true,
  //         autoPlayAnimationDuration: const Duration(milliseconds: 700),
  //         viewportFraction: 0.8,
  //         pageSnapping: true,
  //       ),
  //     ),
  //   );
  // }
}
