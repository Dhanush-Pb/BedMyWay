// import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:bedmyway/repositories/components/mytime_line.dart';
import 'package:flutter/services.dart';

class CancelDetailsPage extends StatelessWidget {
  final String hotelname;
  final String bookeddatte;
  final String cancelddate;
  final String cancelresone;
  final String bookingid;
  final String payment;

  const CancelDetailsPage({
    Key? key,
    required this.hotelname,
    required this.bookeddatte,
    required this.cancelddate,
    required this.cancelresone,
    required this.bookingid,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void copyToClipboard(BuildContext context, String text, String label) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text('$label copied to clipboard'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.red,
        centerTitle: true,
        title: Text(
          'Cancellation Information',
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: ListView(
          children: [
            Mytimeline(
              isFirst: true,
              isLast: false,
              isPrev: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelname,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Booked Date',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    bookeddatte,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Mytimeline(
              isFirst: false,
              isLast: false,
              isPrev: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Cancellation Date',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' $cancelddate',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Mytimeline(
              isFirst: false,
              isLast: true,
              isPrev: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Room Cancelled',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Reason :',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    cancelresone,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        copyToClipboard(context, bookingid, 'Booking ID');
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 16,
                      ),
                    ),
                    const Text(
                      'Booking ID:  ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                      child: Text(
                        bookingid,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        copyToClipboard(context, payment, 'Payment');
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 16,
                      ),
                    ),
                    const Text(
                      'Payment:  ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                      child: Text(
                        payment,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
