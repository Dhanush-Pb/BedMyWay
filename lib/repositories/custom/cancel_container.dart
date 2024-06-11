import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bedmyway/controller/booking/bloc/book_bloc.dart';
import 'package:bedmyway/repositories/components/bottm_page.dart';
import 'package:flutter/material.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CancelButton extends StatefulWidget {
  final String docid;
  const CancelButton({Key? key, required this.docid}) : super(key: key);

  @override
  _CancelButtonState createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
  String? _selectedReason;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Appcolor.shadowcolor.withOpacity(0.5),
            spreadRadius: 0.01,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Cancel Room',
              style: TextStyle(
                color: Appcolor.red2,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedReason,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedReason = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a reason';
                }
                return null;
              },
              items: <String>[
                'Flight Delays',
                'Work Commitments',
                'Natural Disasters',
                'Personal Reasons',
                'Accommodation Overbooking',
                'Travel Companion Issues',
                'Visa or Passport Problems',
                'Transportation Strikes',
                'Unforeseen Events',
                'Emergency Repairs at Home',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Appcolor.red),
                  ),
                );
              }).toList(),
              dropdownColor: Appcolor.white,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                errorStyle: TextStyle(color: Appcolor.blue),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Appcolor.blue),
                ),
                hintText: 'Select a reason',
                hintStyle: TextStyle(color: Appcolor.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final DateTime cancelTime = DateTime.now();
                  final String formattedDate =
                      DateFormat('yyyy-MMMM-dd – hh:mm a').format(cancelTime);
                  BlocProvider.of<BookBloc>(context).add(UpdateBookingEvent(
                    bookingId: widget.docid,
                    updatedData: {
                      'Cancelreson': _selectedReason,
                      'staus': 'Cancelled',
                      'canceltime': formattedDate,
                    },
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AwesomeSnackbarContent(
                        title: 'Cancellation Successfull',
                        message: 'Your request has been submitted.',
                        contentType: ContentType.warning,
                      ),
                      backgroundColor: Appcolor.transpirent,
                      elevation: 0,
                      duration: const Duration(seconds: 4),
                    ),
                  );

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => NavigationMenu()));
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Appcolor.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Appcolor.white),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
