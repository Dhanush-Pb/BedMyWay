import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/view/bottmscrrens/booking_pade.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReusableBottomSheet extends StatefulWidget {
  final double height;
  final String pricePerDay;
  final String touristdetails;
  final String adreess;
  final List<dynamic> TourImages;
  final String hotelname;
  final String contact;
  final List<dynamic> roomImages;
  final String location;

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
  }) : super(key: key);

  @override
  _ReusableBottomSheetState createState() => _ReusableBottomSheetState();
}

class _ReusableBottomSheetState extends State<ReusableBottomSheet> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

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

            // Inside your Widget build method or wherever you are displaying the date range
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  FadePageRoute(
                    page: Bookingsectionpage(
                      TourImages:
                          widget.TourImages, // Use widget to access properties
                      adreess: widget.adreess,
                      touristdetails: widget.touristdetails,
                      contact: widget.contact,
                      price: price,
                      hotelname: widget.hotelname,
                      roomImages: widget.roomImages,
                      location: widget.location,
                    ),
                  ),
                );
              },
              child: Text(
                'Book Now',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Appcolor.red2,
                ),
              ),
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
  required String pricePerDay,
  required String touristdetails,
  required String adreess,
  required List<dynamic> TourImages,
  required String hotelname,
  required String contact,
  required List<dynamic> roomImages,
  required String location,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ReusableBottomSheet(
      height: height,
      pricePerDay: pricePerDay,
      touristdetails: touristdetails,
      adreess: adreess,
      TourImages: TourImages,
      hotelname: hotelname,
      contact: contact,
      roomImages: roomImages,
      location: location,
    ),
  );
}
