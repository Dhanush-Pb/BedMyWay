// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks, avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:bedmyway/Model/google_sing.dart';
import 'package:bedmyway/controller/bloc/auth_bloc.dart';
import 'package:bedmyway/controller/fetchbloc/bloc/hoteldata_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/components/flight_tain.dart';
import 'package:bedmyway/repositories/custom/alertdiloge.dart';
import 'package:bedmyway/repositories/custom/network.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/repositories/custom/shimmer_page.dart';
import 'package:bedmyway/view/bottmscrrens/hotel_details.dart';
import 'package:bedmyway/view/bottmscrrens/search_page.dart';
import 'package:bedmyway/view/bottmscrrens/story_view.dart';
import 'package:bedmyway/view/login/login_page.dart';
import 'package:bedmyway/view/login/sing_up.dart';
import 'package:bedmyway/view/privacypolocy/about_page.dart';
import 'package:bedmyway/view/privacypolocy/community_guid.dart';
import 'package:bedmyway/view/privacypolocy/feedback_.dart';
import 'package:bedmyway/view/privacypolocy/help_page.dart';
import 'package:bedmyway/view/privacypolocy/terms_condition.dart';
import 'package:bedmyway/view/privacypolocy/user_Guide.dart';
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
  int _currentIndex = 0;
  int _currentindex2 = 0;

  @override
  void initState() {
    super.initState();
    currentuserr = FirebaseAuth.instance.currentUser;
    InternetConnectionChecker.start(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        child: AppBar(
          backgroundColor: Appcolor.transpirent,
          elevation: 0,
          title: const Row(
            children: [],
          ),
          leading: PreferredSize(
            preferredSize: const Size(70, kToolbarHeight),
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
            return const CircularProgressIndicator();
          } else if (state is HotelDatafetched) {
            //!carouselItems1
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
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Shimmer.fromColors(
                                        baseColor: Appcolor.shimmercolor1,
                                        highlightColor: Appcolor.Shimmercolor2,
                                        period:
                                            const Duration(milliseconds: 1000),
                                        direction: ShimmerDirection.ltr,
                                        child: Container(color: Appcolor.white),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Shimmer.fromColors(
                                      baseColor: Appcolor.shimmercolor1,
                                      highlightColor: Appcolor.Shimmercolor2,
                                      period: const Duration(
                                          milliseconds:
                                              1000), // Adjust the animation duration
                                      direction: ShimmerDirection
                                          .ltr, // Set the direction of the animation
                                      child: Container(color: Appcolor.white),
                                    );
                                  },
                                )
                              : Shimmer.fromColors(
                                  baseColor: Appcolor.shimmercolor1,
                                  highlightColor: Appcolor.Shimmercolor2,
                                  period: const Duration(
                                      milliseconds:
                                          1000), // Adjust the animation duration
                                  direction: ShimmerDirection
                                      .ltr, // Set the direction of the animation
                                  child: Container(color: Appcolor.white),
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
                          color: Appcolor.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel['name'] ?? 'Hotel Name',
                              style: TextStyle(
                                color: Appcolor.white,
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
                                  style: TextStyle(
                                    color: Appcolor.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Price: ₹${hotel['price'] ?? 'N/A'}',
                                  style: TextStyle(
                                    color: Appcolor.white,
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
            //! CarouselItems2
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
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      // Image successfully
                                      return child;
                                    } else {
                                      //  display shimmer
                                      return Shimmer.fromColors(
                                        baseColor: Appcolor.shimmercolor1,
                                        highlightColor: Appcolor.Shimmercolor2,
                                        child: Container(
                                          color: Appcolor.white,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    //, display shimmer
                                    return Shimmer.fromColors(
                                      baseColor: Appcolor.shimmercolor1,
                                      highlightColor: Appcolor.Shimmercolor2,
                                      child: Container(
                                        color: Appcolor.white,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                      ),
                                    );
                                  },
                                )
                              : Shimmer.fromColors(
                                  baseColor: Appcolor.shimer1,
                                  highlightColor: Appcolor.shimer1,
                                  child: Container(
                                    color: Appcolor.shimer1,
                                    width: double.infinity,
                                    height: 200,
                                  ),
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
                              Text(
                                'Price: ₹${hotel['price'] ?? 'N/A'}',
                                style: TextStyle(
                                  color: Appcolor.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                hotel['Room'] ?? 'Room',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Refund: ${hotel['Refundoption'] ?? 'N/A'}',
                              ),
                            ],
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
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AlternateHotelImagePage(
                                                    coverImages:
                                                        hotel['coverimage'],
                                                    pathImages:
                                                        hotel['pathimage'],
                                                    currentIndex: index,
                                                    hotel: state.hotels[index],
                                                  )));
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AlternateHotelImagePage(
                                                      coverImages:
                                                          hotel['coverimage'],
                                                      pathImages:
                                                          hotel['pathimage'],
                                                      currentIndex: index,
                                                      hotel:
                                                          state.hotels[index],
                                                    )));
                                      },
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: tourimage.isNotEmpty
                                            ? NetworkImage(tourimage.first)
                                            : const AssetImage(
                                                    'assets/images/default_hotel_image.png')
                                                as ImageProvider,
                                      ),
                                    ),
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
                                    height: 185,
                                    aspectRatio: 16 / 9,
                                    autoPlay: true,
                                    autoPlayCurve: Curves.easeInOutSine,
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
                  const TrainPlane(),
                ],
              ),
            );
          }

          return ShimmerClass();
        },
      ),

      //!Drawer
      drawer: Drawer(
        child: Container(
          color: Appcolor.black.withOpacity(0.9),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Appcolor.transpirent,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: currentuserr?.photoURL != null
                          ? NetworkImage(currentuserr!.photoURL!)
                          : const AssetImage(
                              'assets/images/Screenshot 2024-06-23 135849.png',
                            ) as ImageProvider,
                    ),
                    Text(
                      currentuserr?.displayName ??
                          currentuserr?.phoneNumber ??
                          '',
                      style: TextStyle(
                        color: Appcolor.white,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      currentuserr?.email ?? '',
                      style: TextStyle(
                        color: Appcolor.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: Appcolor.white),
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  launchUrl(Uri.parse(
                      'https://doc-hosting.flycricket.io/bedmyway-privacy-policy/f89c647a-a80c-4181-99b4-90d39aca44a5/privacy'));
                },
              ),
              ListTile(
                leading: Icon(Icons.description, color: Appcolor.white),
                title: Text(
                  'Terms & Condition',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TermsAndConditionsPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback, color: Appcolor.white),
                title: Text(
                  'Feedback',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FeedbackPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Appcolor.white),
                title: Text(
                  'Help',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HelpPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.policy, color: Appcolor.white),
                title: Text(
                  'Community Guidelines',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CommunityGuidelinesPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.menu_book, color: Appcolor.white),
                title: Text(
                  'User Guide',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserGuidePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Appcolor.white),
                title: Text(
                  'About',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add, color: Appcolor.white),
                title: Text(
                  'Add Account',
                  style: TextStyle(color: Appcolor.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
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
                          signOut(context);
                          AuthBlocs.add(logoutevent());
                          AuthBlocs.add(GoogleSignOutEvent());
                          Future.delayed(const Duration(milliseconds: 500));
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
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'version 1.0.1',
                    style: TextStyle(color: Appcolor.white),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
