// ignore_for_file: deprecated_member_use, empty_catches, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:bedmyway/Model/goolgle_map.dart';
import 'package:bedmyway/controller/booking/bloc/book_bloc.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/components/bottm_page.dart';
import 'package:bedmyway/repositories/custom/cancel_container.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/view/bottmscrrens/Chat/chatpage.dart';
import 'package:bedmyway/view/bottmscrrens/booking_pade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Bookticketpage extends StatefulWidget {
  final String room;
  final String refund;
  final String hotelName;
  final String bookingID;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String location;
  final String paymentMethod;
  final String totalamoun;
  final String contact;
  final String docid;
  const Bookticketpage({
    required this.hotelName,
    required this.bookingID,
    required this.checkInDate,
    required this.checkOutDate,
    required this.location,
    required this.paymentMethod,
    required this.totalamoun,
    required this.contact,
    required this.docid,
    required this.refund,
    required this.room,
  });

  @override
  _BookticketpageState createState() => _BookticketpageState();
}

class _BookticketpageState extends State<Bookticketpage> {
  late Razorpay _razorpay;
  String? _paymentId;
  double? _rating = 0;
  bool _isPaymentSuccessful = false;

  @override
  void initState() {
    super.initState();
    currentuser = FirebaseAuth.instance.currentUser;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _isPaymentSuccessful = true;
      _paymentId = response.paymentId;
    });

    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Payment Success',
      desc: 'Payment ID: ${response.paymentId}',
      btnOkOnPress: () {
        Navigator.of(context)
            .pushReplacement(FadePageRoute(page: const NavigationMenu()));
      },
    ).show();

    BlocProvider.of<BookBloc>(context).add(UpdateBookingEvent(
      bookingId: widget.docid,
      updatedData: {'payment': _paymentId},
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isPaymentSuccessful = false;
    });

    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Payment failed ',
      btnCancelOnPress: () {},
    ).show();
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_fAcHyoe9ZluWWI',
      'amount': (int.parse(widget.totalamoun.replaceAll(',', '')) - 100) * 100,
      'name': widget.hotelName,
      'description': 'Booking Payment',
      'prefill': {
        'contact': '',
        'email': 'example@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.red,
        centerTitle: true,
        title: Text(
          'Hotel Reservation Info',
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Hotel Name: ${widget.hotelName}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              const SizedBox(height: 20),
              Text(
                'Booking ID: ${widget.bookingID}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Check-In Date:  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    _formatDate(widget.checkInDate),
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Check-Out Date:  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    _formatDate(widget.checkOutDate),
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Location: ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.location,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Room: ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.room,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'TotalAmount: ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.totalamoun,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Payment: ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    _paymentId ?? widget.paymentMethod,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Refund: ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.refund,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get ₹100 off when you pay online!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.green,
                    ),
                  ),
                  Text(
                    '₹ ${(int.parse(widget.totalamoun.replaceAll(',', '')) - 100)}',
                    style: TextStyle(
                      color: Appcolor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _isPaymentSuccessful
                  ? const Text(
                      'Payment Successful!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Visibility(
                      visible: widget.paymentMethod == 'Pay at Hotel',
                      child: InkWell(
                        onTap: () {
                          _openCheckout();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Appcolor.shadowcolor.withOpacity(0.5),
                                spreadRadius: 0.01,
                                blurRadius: 1,
                                offset: const Offset(0, 3),
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
                                '₹ ${(int.parse(widget.totalamoun.replaceAll(',', '')) - 100)}',
                                style: TextStyle(
                                  color: Appcolor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Pay Now',
                                style: TextStyle(
                                  color: Appcolor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionItem(
                    icon: FontAwesomeIcons.mapMarkerAlt,
                    label: 'Directions',
                    onTap: () {
                      openMap(
                          hotelname: widget.hotelName,
                          loc: widget.location,
                          address: '');
                    },
                  ),
                  _buildActionItem(
                    icon: FontAwesomeIcons.phone,
                    label: 'Call',
                    onTap: () {
                      makeCall(widget.contact);
                    },
                  ),
                  _buildActionItem(
                    icon: FontAwesomeIcons.comment,
                    label: 'Message',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(
                              senderEmail: currentuser?.email ?? '',
                              receiverId: widget.bookingID,
                              hotelname: widget.hotelName,
                              phonenumber: widget.contact)));
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 26,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Appcolor.ratingcolor,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          if (_rating != 0) {
                            BlocProvider.of<BookBloc>(context)
                                .add(UpdateBookingEvent(
                              bookingId: widget.docid,
                              updatedData: {'Rating': _rating},
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: AwesomeSnackbarContent(
                                  title: 'Rating Submitted!',
                                  message: 'Thank you for rating your stay!',
                                  contentType: ContentType.success,
                                ),
                                backgroundColor: Appcolor.transpirent,
                                elevation: 0,
                                duration: const Duration(seconds: 4),
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Appcolor.blue),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // Add share functionality here
                      _shareTicket();
                    },
                    icon: const Icon(Icons.share),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CancelButton(
                docid: widget.docid,
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final dateFormat = DateFormat('dd/MMMM/yyyy');
    return dateFormat.format(date);
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
            color: Appcolor.black,
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

  void _shareTicket() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final String text =
        'Explore the details of your booking at ${widget.hotelName}!'
        ' Booking ID: ${widget.bookingID}, Payment: ${widget.paymentMethod}';

    Share.share(text,
        subject: 'Booking Details',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
