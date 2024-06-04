import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/components/bottm_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class Bookingsectionpage extends StatefulWidget {
  final List<dynamic> TourImages; // Change dynamic to String
  final String adreess;
  final String touristdetails;
  final String contact;
  final String price;
  final String hotelname;
  final List<dynamic> roomImages; // Change dynamic to String

  const Bookingsectionpage({
    Key? key,
    required this.TourImages,
    required this.adreess,
    required this.touristdetails,
    required this.contact,
    required this.price,
    required this.hotelname,
    required this.roomImages,
  }) : super(key: key);

  @override
  State<Bookingsectionpage> createState() => _BookingsectionpageState();
}

class _BookingsectionpageState extends State<Bookingsectionpage> {
  @override
  Widget build(BuildContext context) {
    // Ensure roomImages is not null

    List<String> validRoomImages = widget.roomImages
        .where((image) => image != null)
        .map<String>((image) => image as String)
        .toList();
    final price = widget.price;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NavigationMenu()));
          },
          icon: Icon(Icons.close_outlined),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Appcolor.blue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              height: 150,
              alignment: Alignment.center,
              child: const Text(
                'Your Booking is Confirmed',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hotelname,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Text(
                        'Address: ${widget.adreess}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 130,
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: validRoomImages.isNotEmpty
                                  ? Image.network(
                                      validRoomImages[0],
                                      fit: BoxFit.cover,
                                    )
                                  : Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: validRoomImages.isNotEmpty
                                  ? Image.network(
                                      validRoomImages[1],
                                      fit: BoxFit.cover,
                                    )
                                  : Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Get 10% off when you pay online!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Column(
                        children: [
                          Stack(
                            children: [
                              Text(
                                widget.price,
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
                                  color:
                                      const Color.fromARGB(154, 70, 157, 228),
                                  width: 90, // Adjust width as needed
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${(int.parse(widget.price.replaceAll(',', '')) - 100)}',
                            style: TextStyle(
                              color: Appcolor.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(99, 146, 137, 137)
                              .withOpacity(0.5),
                          spreadRadius: 0.01,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Appcolor.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(int.parse(widget.price.replaceAll(',', '')) - 100)}',
                          style: const TextStyle(
                            color: Colors.white,
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
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionItem(
                        // ignore: deprecated_member_use
                        icon: FontAwesomeIcons.mapMarkerAlt,
                        label: 'Directions',
                        onTap: () {
                          // Handle directions action
                        },
                      ),
                      _buildActionItem(
                        icon: FontAwesomeIcons.phone,
                        label: 'Call',
                        onTap: () {
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
                  const SizedBox(height: 30),
                  const Text(
                    'Explore Nearby Beauty',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Description: ${widget.touristdetails}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required void Function() onTap,
  }) {
    return GestureDetector(
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
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
