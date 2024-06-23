// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bedmyway/Model/goolgle_map.dart';
import 'package:bedmyway/controller/booking/bloc/book_bloc.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/components/bottm_page.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

class Bookingsectionpage extends StatefulWidget {
  final List<dynamic> TourImages;
  final String adreess;
  final String touristdetails;
  final String contact;
  final String price;
  final String hotelname;
  final String location;
  final List<dynamic> roomImages;
  final String docid;

  const Bookingsectionpage({
    Key? key,
    required this.TourImages,
    required this.adreess,
    required this.touristdetails,
    required this.contact,
    required this.price,
    required this.hotelname,
    required this.roomImages,
    required this.location,
    required this.docid,
  }) : super(key: key);

  @override
  State<Bookingsectionpage> createState() => _BookingsectionpageState();
}

class _BookingsectionpageState extends State<Bookingsectionpage> {
  bool showtourimage = false;
  int _currentindexT = 0;
  late Razorpay _razorpay;
  String? _paymentId;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _paymentId = response.paymentId;
    });
    print('THIS IS DOC ID ');
    print(widget.docid);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Payment Success',
      desc: 'Payment ID: ${response.paymentId}',
      btnOkOnPress: () {},
    ).show();
    BlocProvider.of<BookBloc>(context).add(UpdateBookingEvent(
      bookingId: widget.docid,
      updatedData: {'payment': _paymentId},
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Payment failed ',
      // desc: 'Payment Eroor: ${response.code}-${response.message}',
      btnCancelOnPress: () {},
    ).show();
    //Text('Payment Error: ${response.code} - ${response.message}')),
  }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('External Wallet: ${response.walletName}')),
  //   );
  // }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_fAcHyoe9ZluWWI',
      'amount': (int.parse(widget.price.replaceAll(',', '')) - 100) * 100,
      'name': widget.hotelname,
      'description': 'Booking Payment',
      'prefill': {
        'contact': widget.contact,
        'email': 'dhanushpb59@gmail.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> validRoomImages = widget.roomImages
        .where((image) => image != null)
        .map<String>((image) => image as String)
        .toList();

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
                    child: Text(
                      'Your Booking is Confirmed',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Appcolor.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 130,
                                  width:
                                      MediaQuery.of(context).size.width * 0.44,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: validRoomImages.isNotEmpty
                                        ? Image.network(
                                            validRoomImages[0],
                                            fit: BoxFit.cover,
                                          )
                                        : Shimmer.fromColors(
                                            baseColor: Appcolor.shimmercolor1,
                                            highlightColor:
                                                Appcolor.Shimmercolor2,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  height: 130,
                                  width:
                                      MediaQuery.of(context).size.width * 0.44,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: validRoomImages.isNotEmpty
                                        ? Image.network(
                                            validRoomImages[1],
                                            fit: BoxFit.cover,
                                          )
                                        : Shimmer.fromColors(
                                            baseColor: Appcolor.shimmercolor1,
                                            highlightColor:
                                                Appcolor.Shimmercolor2,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Get ₹100 off when you pay online!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Appcolor.green,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Text(
                                        '₹ ${widget.price}',
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
                                          color: const Color.fromARGB(
                                                  154, 70, 157, 228)
                                              .withOpacity(0.5),
                                          width: 90, // Adjust width as needed
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            _openCheckout();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(99, 146, 137, 137)
                                      .withOpacity(0.5),
                                  spreadRadius: 0.01,
                                  blurRadius: 1,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Appcolor.red,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '₹ ${(int.parse(widget.price.replaceAll(',', '')) - 100)}',
                                  style: TextStyle(
                                    color: Appcolor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildActionItem(
                              icon: FontAwesomeIcons.mapMarkerAlt,
                              label: 'Directions',
                              onTap: () {
                                openMap(
                                    hotelname: widget.hotelname,
                                    loc: widget.location,
                                    address: widget.adreess);
                              },
                            ),
                            _buildActionItem(
                              icon: FontAwesomeIcons.phone,
                              label: 'Call',
                              onTap: () {
                                makeCall(widget.contact);
                                // Handle call action
                              },
                            ),
                            _buildActionItem(
                              icon: FontAwesomeIcons.comment,
                              label: 'Message',
                              onTap: () {
                                // Handle message action
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
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
                                            baseColor: Appcolor.shimmercolor1,
                                            highlightColor:
                                                Appcolor.Shimmercolor2,
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
                                          baseColor: Appcolor.shimmercolor1,
                                          highlightColor:
                                              Appcolor.Shimmercolor2,
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

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 27,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Appcolor.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
