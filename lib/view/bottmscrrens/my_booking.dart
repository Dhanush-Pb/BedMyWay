// ignore_for_file: unused_local_variable

import 'package:bedmyway/controller/booking/bloc/book_bloc.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/view/bottmscrrens/cancel_details.dart';
import 'package:bedmyway/view/bottmscrrens/ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Mybooking extends StatefulWidget {
  const Mybooking({Key? key});

  @override
  State<Mybooking> createState() => _MybookingState();
}

class _MybookingState extends State<Mybooking> {
  @override
  void initState() {
    final bookBloc = BlocProvider.of<BookBloc>(context);

    bookBloc.add(FetchBookingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookBloc = BlocProvider.of<BookBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Appcolor.red,
        title: Text(
          'My Bookings',
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      backgroundColor: Appcolor.white,
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            bookBloc.add(FetchBookingEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingFetched) {
            if (state.bookingData.isEmpty) {
              return _buildEmptyState();
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  bookBloc.add(FetchBookingEvent());
                },
                child: _buildBookingList(state.bookingData),
              );
            }
          } else if (state is BookError) {
            print(state.error.toString());
            return Center(child: _buildEmptyState());
          }
          return Center(child: _buildEmptyState());
        },
      ),
    );
  }

  Widget _buildBookingList(Map<String, dynamic> bookingData) {
    List bookings = bookingData.values.toList();

    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        String hotelName = booking['Hotalnmae'] ?? 'Hotel';
        String location = booking['Location'] ?? 'Location';
        String checkInDate =
            booking['checkInDate']?.toDate()?.toString() ?? 'Check-In Date';
        String checkOutDate =
            booking['checkOutDate']?.toDate()?.toString() ?? 'Check-Out Date';
        String paymentMethod = booking['payment'] ?? 'Payment Method';
        String bookingID = booking['hotelDocId'] ?? 'Booking ID';

        double? rating = booking['Rating'] != null
            ? double.tryParse(booking['Rating'].toString())
            : null;
        String ratingString = rating != null ? rating.toString() : 'No Rating';
        String status = booking['staus'];
        Color statusColor = status.toLowerCase() == 'cancelled'
            ? Appcolor.red2
            : Appcolor.green;
        DateTime bookingDate =
            DateFormat('yyyy-MMMM-dd – hh:mm a').parse(booking['bookeddate']);
        String formattedDate = DateFormat('yyyy-MMMM-dd').format(bookingDate);
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    hotelName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 15,
                      color: Appcolor.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  buildRatingStars(
                      rating ?? 0.0), // Pass rating or default value
                ],
              ),
              trailing: Column(
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    status, // Handle null status
                    style: TextStyle(color: statusColor, fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                String status = booking['staus'] ?? 'Status not available';
                if (status.toLowerCase() == 'cancelled') {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CancelDetailsPage(
                      hotelname: hotelName,
                      bookeddatte: booking['bookeddate'].toString(),
                      cancelddate: booking['canceltime'].toString(),
                      cancelresone: booking['Cancelreson'],
                      bookingid: booking['hotelDocId'] ?? '',
                      payment: paymentMethod,
                    ),
                  ));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Bookticketpage(
                      hotelName: hotelName,
                      bookingID: bookingID,
                      checkInDate: DateTime.parse(checkInDate),
                      checkOutDate: DateTime.parse(checkOutDate),
                      location: location,
                      paymentMethod: paymentMethod,
                      totalamoun: booking['TotalAmount'],
                      contact: booking['contact'],
                      docid: booking['id'],
                      refund: booking['Refunnd'],
                      room: booking['Room'],
                    ),
                  ));
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Screenshot 2024-06-08 200827.png',
          width: 220,
        ),
        const Text('No booking info')
      ],
    ));
  }

  Widget buildRatingStars(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < rating.floor(); i++) {
      stars.add(Icon(
        Icons.star,
        color: Appcolor.ratingcolor,
        size: 16,
      ));
    }
    if (rating - rating.floor() > 0) {
      stars.add(Icon(
        Icons.star_half,
        color: Appcolor.ratingcolor,
        size: 16,
      ));
    }
    return Row(children: stars);
  }
}
