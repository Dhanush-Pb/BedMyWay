// ignore_for_file: unused_field

import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bedmyway/controller/booking/bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/view/bottmscrrens/booking_pade.dart';

class ReusableBottomSheet extends StatefulWidget {
  final String refund;
  final double height;
  final String pricePerDay;
  final String touristdetails;
  final String adreess;
  final List<dynamic> TourImages;
  final String hotelname;
  final String contact;
  final List<dynamic> roomImages;
  final String location;
  final String room;
  final String hotelDocId; // Added hotelDocId parameter

  const ReusableBottomSheet({
    Key? key,
    this.height = 300.0,
    required this.pricePerDay,
    required this.touristdetails,
    required this.adreess,
    required this.TourImages,
    required this.hotelname,
    required this.contact,
    required this.roomImages,
    required this.location,
    required this.room,
    required this.hotelDocId,
    required this.refund, // Added hotelDocId parameter
  }) : super(key: key);

  @override
  _ReusableBottomSheetState createState() => _ReusableBottomSheetState();
}

class _ReusableBottomSheetState extends State<ReusableBottomSheet> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? _docid;

  @override
  Widget build(BuildContext context) {
    int totalDays = selectedStartDate != null && selectedEndDate != null
        ? selectedEndDate!.difference(selectedStartDate!).inDays
        : 0;
    final price =
        (double.parse(widget.pricePerDay.replaceAll(',', '')) * totalDays)
            .toStringAsFixed(0);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'Select Your Stay Dates ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                'Select Dates',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Appcolor.blue),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (selectedStartDate != null && selectedEndDate != null) ...[
            const Text(
              'Selected Dates',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${DateFormat('yyyy MMMM d').format(selectedStartDate!)}  to  ${DateFormat('yyyy MMMM d').format(selectedEndDate!)}',
              style: TextStyle(
                  fontSize: 16,
                  color: Appcolor.blue,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Days: $totalDays',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TotalAmount ₹ ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  (double.parse(widget.pricePerDay.replaceAll(',', '')) *
                          totalDays)
                      .toStringAsFixed(0),
                  style: TextStyle(
                      fontSize: 18,
                      color: Appcolor.red2,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(height: 20),
            BlocConsumer<BookBloc, BookState>(
              listener: (context, state) {
                if (state is BookSuccess) {
                  log(state.docid);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AwesomeSnackbarContent(
                        title: 'Booking Successful!',
                        message:
                            'Your booking has been confirmed. Enjoy your stay!',
                        contentType: ContentType.success,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0, // Elevation

                      duration:
                          Duration(seconds: 4), // Duration to show the snackbar
                    ),
                  );
                  Navigator.of(context).pushReplacement(
                    FadePageRoute(
                      page: Bookingsectionpage(
                        TourImages: widget.TourImages,
                        adreess: widget.adreess,
                        touristdetails: widget.touristdetails,
                        contact: widget.contact,
                        price: price,
                        hotelname: widget.hotelname,
                        roomImages: widget.roomImages,
                        location: widget.location,
                        docid: state.docid,
                      ),
                    ),
                  );
                  SnackBar;
                } else if (state is BookError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking failed: ${state.error}')),
                  );
                }
              },
              builder: (context, state) {
                if (state is BookLoading) {
                  return CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () {
                    final DateTime bookTime = DateTime.now();
                    final String formattedDate =
                        DateFormat('yyyy-MMMM-dd – hh:mm a').format(bookTime);
                    final bookingData = {
                      'bookeddate': formattedDate,
                      'checkInDate': Timestamp.fromDate(selectedStartDate!),
                      'checkOutDate': Timestamp.fromDate(selectedEndDate!),
                      'Hotalnmae': widget.hotelname,
                      'Roomtype': widget.room,
                      'payment': 'Pay at Hotel',
                      'TotalAmount': price,
                      'Location': widget.location,
                      'Rating': '',
                      'contact': widget.contact,
                      'staus': 'Booked',
                      'Cancelreson': '',
                      'canceltime': '',
                      'Room': widget.room,
                      'Refunnd': widget.refund,
                      'hotelDocId': widget.hotelDocId
                    };
                    if (state is BookLoading) {}

                    context.read<BookBloc>().add(BookHotelEvent(
                        hotelDocId: widget.hotelDocId,
                        bookingData: bookingData));
                  },
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Appcolor.red2,
                    ),
                  ),
                );
              },
            ),
          ] else ...[
            // Display a default image when no dates are selected
            SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                        'assets/images/Screenshot 2024-06-06 214012.png')
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedStartDate = picked.start;
        selectedEndDate = picked.end;
      });
    }
  }
}

void showReusableBottomSheet({
  required BuildContext context,
  double height = 300.0,
  required String room,
  required String pricePerDay,
  required String touristdetails,
  required String adreess,
  required List<dynamic> TourImages,
  required String hotelname,
  required String contact,
  required List<dynamic> roomImages,
  required String location,
  required String hotelDocId,
  required String refund,
  // Added hotelDocId parameter
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ReusableBottomSheet(
      room: room,
      height: height,
      pricePerDay: pricePerDay,
      touristdetails: touristdetails,
      adreess: adreess,
      TourImages: TourImages,
      hotelname: hotelname,
      contact: contact,
      roomImages: roomImages,
      location: location,
      hotelDocId: hotelDocId,
      refund: refund,
    ),
  );

// // }
// import 'dart:developer';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:bedmyway/controller/booking/bloc/book_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:bedmyway/repositories/colors/colors.dart';
// import 'package:bedmyway/repositories/custom/page_transition.dart';
// import 'package:bedmyway/view/bottmscrrens/booking_pade.dart';

// class ReusableBottomSheet extends StatefulWidget {
//   final String refund;
//   final double height;
//   final String pricePerDay;
//   final String touristDetails;
//   final String address;
//   final List<dynamic> tourImages;
//   final String hotelName;
//   final String contact;
//   final List<dynamic> roomImages;
//   final String location;
//   final String room;
//   final String hotelDocId; // Added hotelDocId parameter

//   const ReusableBottomSheet({
//     Key? key,
//     this.height = 300.0,
//     required this.pricePerDay,
//     required this.touristDetails,
//     required this.address,
//     required this.tourImages,
//     required this.hotelName,
//     required this.contact,
//     required this.roomImages,
//     required this.location,
//     required this.room,
//     required this.hotelDocId,
//     required this.refund, // Added hotelDocId parameter
//   }) : super(key: key);

//   @override
//   _ReusableBottomSheetState createState() => _ReusableBottomSheetState();
// }

// class _ReusableBottomSheetState extends State<ReusableBottomSheet> {
//   DateTime? selectedStartDate;
//   DateTime? selectedEndDate;
//   String? _docId;

//   @override
//   Widget build(BuildContext context) {
//     int totalDays = selectedStartDate != null && selectedEndDate != null
//         ? selectedEndDate!.difference(selectedStartDate!).inDays
//         : 0;
//     final price =
//         (double.parse(widget.pricePerDay.replaceAll(',', '')) * totalDays)
//             .toStringAsFixed(0);

//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: const EdgeInsets.all(20.0),
//       decoration: BoxDecoration(
//         color: Appcolor.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           const Center(
//             child: Text(
//               'Select Your Stay Dates',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Center(
//             child: ElevatedButton(
//               onPressed: () => _selectDate(context),
//               child: Text(
//                 'Select Dates',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Appcolor.blue),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           if (selectedStartDate != null && selectedEndDate != null) ...[
//             const Text(
//               'Selected Dates',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${DateFormat('yyyy MMMM d').format(selectedStartDate!)} to ${DateFormat('yyyy MMMM d').format(selectedEndDate!)}',
//               style: TextStyle(
//                   fontSize: 16,
//                   color: Appcolor.blue,
//                   fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Total Days: $totalDays',
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Total Amount ₹ ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   (double.parse(widget.pricePerDay.replaceAll(',', '')) *
//                           totalDays)
//                       .toStringAsFixed(0),
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Appcolor.red2,
//                       fontWeight: FontWeight.w600),
//                 )
//               ],
//             ),
//             const SizedBox(height: 20),
//             BlocConsumer<BookBloc, BookState>(
//               listener: (context, state) {
//                 if (state is BookSuccess) {
//                   log(state.docid);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: AwesomeSnackbarContent(
//                         title: 'Booking Successful!',
//                         message:
//                             'Your booking has been confirmed. Enjoy your stay!',
//                         contentType: ContentType.success,
//                       ),
//                       backgroundColor: Colors.transparent,
//                       elevation: 0,
//                       duration: Duration(seconds: 4),
//                     ),
//                   );
//                   Navigator.of(context).pushReplacement(
//                     FadePageRoute(
//                       page: Bookingsectionpage(
//                         TourImages: widget.tourImages,
//                         adreess: widget.address,
//                         touristdetails: widget.touristDetails,
//                         contact: widget.contact,
//                         price: price,
//                         hotelname: widget.hotelName,
//                         roomImages: widget.roomImages,
//                         location: widget.location,
//                         docid: state.docid,
//                       ),
//                     ),
//                   );
//                 } else if (state is BookError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Booking failed: ${state.error}')),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 if (state is BookLoading) {
//                   return CircularProgressIndicator();
//                 }

//                 return ElevatedButton(
//                   onPressed: () {
//                     final DateTime bookTime = DateTime.now();
//                     final String formattedDate =
//                         DateFormat('yyyy-MMMM-dd – hh:mm a').format(bookTime);
//                     final bookingData = {
//                       'bookedDate': formattedDate,
//                       'checkInDate': Timestamp.fromDate(selectedStartDate!),
//                       'checkOutDate': Timestamp.fromDate(selectedEndDate!),
//                       'hotelName': widget.hotelName,
//                       'roomType': widget.room,
//                       'payment': 'Pay at Hotel',
//                       'totalAmount': price,
//                       'location': widget.location,
//                       'rating': '',
//                       'contact': widget.contact,
//                       'status': 'Booked',
//                       'cancelReason': '',
//                       'cancelTime': '',
//                       'room': widget.room,
//                       'refund': widget.refund
//                     };

//                     context.read<BookBloc>().add(BookHotelEvent(
//                         hotelDocId: widget.hotelDocId,
//                         bookingData: bookingData));
//                   },
//                   child: Text(
//                     'Book Now',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 17,
//                       color: Appcolor.red2,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ] else ...[
//             // Display a default image when no dates are selected
//             SizedBox(
//               width: 200,
//               height: 200,
//               child: Center(
//                 child: Column(
//                   children: [
//                     Image.asset('assets/images/Screenshot 2024-06-06 214012.png')
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   void _selectDate(BuildContext context) async {
//     final DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null) {
//       setState(() {
//         selectedStartDate = picked.start;
//         selectedEndDate = picked.end;
//       });
//     }
//   }
// }

// void showReusableBottomSheet({
//   required BuildContext context,
//   double height = 300.0,
//   required String room,
//   required String pricePerDay,
//   required String touristDetails,
//   required String address,
//   required List<dynamic> tourImages,
//   required String hotelName,
//   required String contact,
//   required List<dynamic> roomImages,
//   required String location,
//   required String hotelDocId,
//   required String refund,
// }) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => ReusableBottomSheet(
//       room: room,
//       height: height,
//       pricePerDay: pricePerDay,
//       touristDetails: touristDetails,
//       address: address,
//       tourImages: tourImages,
//       hotelName: hotelName,
//       contact: contact,
//       roomImages: roomImages,
//       location: location,
//       hotelDocId: hotelDocId,
//       refund: refund,
//     ),
//   );
// }
}
