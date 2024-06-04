import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/view/bottmscrrens/booking_pade.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class HotelDetailPage extends StatefulWidget {
  final Map<String, dynamic> hotel;

  const HotelDetailPage({Key? key, required this.hotel}) : super(key: key);

  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  int _currentIndex = 0;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final roomImages = widget.hotel['images'] as List<dynamic>;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
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
                            return Image.network(
                              image,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: const Color.fromARGB(
                                          255, 123, 123, 123),
                                      child: const Center(
                                        child: Text(
                                          'Loading...',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
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
                              color: _isFavorite ? Colors.red : Colors.white,
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
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            height: 8.0,
                            width: _currentIndex == index ? 19.0 : 8.0,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? const Color.fromARGB(255, 255, 5, 5)
                                  : Colors.grey,
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
                            style: const TextStyle(fontWeight: FontWeight.w600),
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
                              const Icon(
                                Icons.star_purple500_outlined,
                                color: Color.fromARGB(255, 236, 213, 4),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '3/5',
                                style: TextStyle(
                                  color: Appcolor.black,
                                ),
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
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'View on Map',
                        style: TextStyle(fontSize: 15, color: Appcolor.blue),
                      ),
                      Text('Wifi: ${widget.hotel['wifi']}')
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'About the Hotel',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text('Refund: ${widget.hotel['Refundoption']}')
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Room type: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.hotel['Room'],
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context).push(FadePageRoute(
              page: Bookingsectionpage(
            touristdetails: widget.hotel['touristlocaton'],
            adreess: widget.hotel['sinceYear'],
            TourImages: widget.hotel['tourimage'],
            price: widget.hotel['price'],
            contact: widget.hotel['contact'],
            hotelname: widget.hotel['name'],
            roomImages: widget.hotel['images'],
          )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 244, 242, 242),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 1,
                offset: const Offset(0, 3), // changes position of shadow
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
                        '\$ ${(double.parse(widget.hotel['price'].replaceAll(',', '')) * 1.5).toStringAsFixed(1)}',
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
                          color: const Color.fromARGB(154, 70, 157, 228),
                          width: 90, // Adjust width as needed
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$ ${widget.hotel['price']}',
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
