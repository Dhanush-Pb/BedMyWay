// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:ui';

import 'package:bedmyway/Model/goolgle_map.dart';
import 'package:bedmyway/controller/Ratebloc/bloc/rating_bloc.dart';
import 'package:bedmyway/controller/booking/bloc/book_bloc.dart';
import 'package:bedmyway/repositories/components/bottm_sheet.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/view/bottmscrrens/more_info.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HotelDetailPage extends StatefulWidget {
  final Map<String, dynamic> hotel;

  const HotelDetailPage({Key? key, required this.hotel}) : super(key: key);

  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  int _currentIndex = 0;
  int _currentindex2 = 0;
  bool _isFavorite = false;
  bool _showimagepriviw = false;

  @override
  Widget build(BuildContext context) {
    final roomImages = widget.hotel['images'] as List<dynamic>;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showimagepriviw = !_showimagepriviw;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height,
                              viewportFraction: 1.0,
                              autoPlay: true,
                              onPageChanged: (index, _) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: roomImages.map((image) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: Image.network(
                                        image,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Shimmer.fromColors(
                                              baseColor: Appcolor.shimmercolor1,
                                              highlightColor:
                                                  Appcolor.Shimmercolor2,
                                              child: Container(
                                                color: Appcolor.white,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 200,
                                              ),
                                            );
                                          }
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(
                                                255, 111, 111, 111),
                                            highlightColor:
                                                const Color.fromARGB(
                                                    255, 196, 195, 195),
                                            child: Container(
                                              color: const Color.fromARGB(
                                                  255, 187, 187, 187),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                            top: 40,
                            right: 16,
                            child: Column(
                              children: [
                                Text(
                                  '${_currentIndex + 1}/ ${roomImages.length}',
                                  style: TextStyle(
                                    color: Appcolor.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                IconButton(
                                  icon: Icon(
                                    _isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _isFavorite
                                        ? Appcolor.red2
                                        : Appcolor.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isFavorite = !_isFavorite;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: roomImages.asMap().entries.map((entry) {
                                int index = entry.key;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  height: 8.0,
                                  width: _currentIndex == index ? 19.0 : 8.0,
                                  decoration: BoxDecoration(
                                    color: _currentIndex == index
                                        ? Appcolor.red2
                                        : Appcolor.grey,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.hotel['name'] ?? 'Hotel Name',
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Appcolor.red2,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                widget.hotel['locaton'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.star_purple500_outlined,
                                    color: Appcolor.ratingcolor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  BlocConsumer<RatingBloc, RatingState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      if (state is HotelRatingdataLoading) {
                                        return const CircularProgressIndicator();
                                      } else if (state is Ratingdatafetched) {
                                        // Find all hotels with the matching name
                                        final matchingHotels =
                                            state.hotels.where(
                                          (hotel) =>
                                              hotel['Hotalnmae'] ==
                                              widget.hotel['name'],
                                        );

                                        if (matchingHotels.isNotEmpty) {
                                          // Calculate the total rating
                                          final totalRating = matchingHotels
                                              .fold(0.0, (sum, hotel) {
                                            final rating = hotel['Rating'];
                                            return sum +
                                                (rating is double
                                                    ? rating
                                                    : double.tryParse(rating) ??
                                                        0.0);
                                          });

                                          // Calculate the average rating
                                          final averageRating = totalRating /
                                              matchingHotels.length;

                                          return Column(
                                            children: [
                                              Text(
                                                '${averageRating.toStringAsFixed(1)}/5',
                                                style: TextStyle(
                                                  color: Appcolor.black,
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Text(
                                            'No matching hotels foun',
                                            style: TextStyle(
                                              color: Appcolor.black,
                                            ),
                                          );
                                        }
                                      }
                                      // Default case when the state is neither loading nor fetched
                                      return Text(
                                        '3.5',
                                        style: TextStyle(
                                          color: Appcolor.black,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.hotel['sinceYear'] ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Appcolor.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              openMap(
                                  hotelname: widget.hotel['name'],
                                  loc: widget.hotel['locaton'],
                                  address: widget.hotel['sinceYear']);
                            },
                            child: Text(
                              'View on Map',
                              style:
                                  TextStyle(fontSize: 15, color: Appcolor.blue),
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Ac: ',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(widget.hotel['acoption'])
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'About the Hotel',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Refund: ',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(widget.hotel['Refundoption'])
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Room type : ',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.hotel['Room'],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Wifi: ',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(widget.hotel['wifi'])
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Food: ',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(widget.hotel['foodoption']),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(FadePageRoute(
                                  page: MoreInfoPage(
                                touristdetails: widget.hotel['touristlocaton'],
                                adreess: widget.hotel['sinceYear'],
                                TourImages: widget.hotel['tourimage'],
                                contact: widget.hotel['contact'],
                                hotelname: widget.hotel['name'],
                                roomImages: widget.hotel['images'],
                                location: widget.hotel['locaton'],
                                messageDirection: '',
                              )));
                            },
                            child: Text(
                              'Moreinifo',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Appcolor.blue),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.hotel['description'] ?? 'Hotel Description',
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "The choice BedMyWay property comes with a promise of 8 assured amenities, money-back guarantee and priority helpline support. You also get free cancellation and standardized prices through the year.",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //! image view
          if (_showimagepriviw)
            Stack(
              children: [
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                    child: Container(
                      height: 300,
                      color: Appcolor.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.22,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Stack(
                      children: [
                        CarouselSlider.builder(
                          itemCount: roomImages.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                roomImages[itemIndex],
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Shimmer.fromColors(
                                      baseColor: Appcolor.shimmercolor1,
                                      highlightColor: Appcolor.Shimmercolor2,
                                      child: Container(
                                        color: Appcolor.black,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 160,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Shimmer.fromColors(
                                    baseColor: Appcolor.shimmercolor1,
                                    highlightColor: Appcolor.Shimmercolor2,
                                    child: Container(
                                      color: Appcolor.white,
                                      width: MediaQuery.of(context).size.width,
                                      height: 160,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.4,
                            viewportFraction: 1.0,
                            initialPage: _currentindex2,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentindex2 = index;
                              });
                            },
                          ),
                        ),
                        Positioned(
                          top: 18,
                          right: 20,
                          child: IconButton(
                            highlightColor: Appcolor.red,
                            icon: Icon(Icons.close, color: Appcolor.white),
                            onPressed: () {
                              setState(() {
                                _showimagepriviw = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.25,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: roomImages.asMap().entries.map((entry) {
                      int index = entry.key;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        height: 8.0,
                        width: _currentindex2 == index ? 23.0 : 8.0,
                        decoration: BoxDecoration(
                          color: _currentindex2 == index
                              ? Appcolor.red
                              : Appcolor.grey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.24,
                    left: MediaQuery.of(context).size.width * 0.86,
                    right: 0,
                    child: Text(
                      '${_currentindex2 + 1}/${roomImages.length}',
                      style: TextStyle(
                          color: Appcolor.white, fontWeight: FontWeight.w600),
                    )),
              ],
            ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          final price = widget.hotel['price'];

          showReusableBottomSheet(
            context: context,
            pricePerDay: price,
            touristdetails: widget.hotel['touristlocaton'],
            adreess: widget.hotel['sinceYear'],
            TourImages: widget.hotel['tourimage'],
            contact: widget.hotel['contact'],
            hotelname: widget.hotel['name'],
            roomImages: widget.hotel['images'],
            location: widget.hotel['locaton'],
            room: widget.hotel['Room'],
            hotelDocId: widget.hotel['id'],
            refund: widget.hotel['Refundoption'],
          );

          // Navigator.of(context).push(FadePageRoute(
          //     page: Bookingsectionpage(

          // )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Appcolor.white,
            boxShadow: [
              BoxShadow(
                color: Appcolor.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Stack(
                    children: [
                      Text(
                        '₹ ${(double.parse(widget.hotel['price'].replaceAll(',', '')) * 1.5).toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 0,
                        child: Container(
                          height: 2,
                          color: Appcolor.blue2,
                          width: 90, // Adjust width as needed
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹ ${widget.hotel['price']}',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ), // Add some spacing
                ],
              ),
              const Spacer(),
              const Spacer(flex: 4),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Appcolor.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Book now & Pay at Hotel',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                      color: Appcolor.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
