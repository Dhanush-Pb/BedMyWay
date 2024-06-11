// ignore_for_file: deprecated_member_use

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openMap({String? hotelname, String? loc, String? address}) async {
  final String hotelName = hotelname ?? '';
  final String location = loc ?? '';
  final String sinceYear = address ?? '';
  final String query = Uri.encodeComponent('$hotelName,$location,$sinceYear');
  final String googleMapsUrl =
      'https://www.google.com/maps/dir/?api=1&destination=$query&travelmode=driving';

  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  } else {
    throw 'Could not launch $googleMapsUrl';
  }
}

Future<void> makeCall(String contact) async {
  final String phoneNumber = contact;
  final String telUrl = 'tel:$phoneNumber';
  FlutterPhoneDirectCaller.callNumber(telUrl);
  try {
    if (await canLaunch(telUrl)) {
      await launch(telUrl);
    } else {
      throw 'Could not launch $telUrl';
    }
  } catch (e) {
    print('Error launching phone call: $e');
  }
}
