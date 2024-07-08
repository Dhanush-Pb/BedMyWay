// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messagethings {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final String currentUserId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final String hotelName;
  final Timestamp timestamp;
  final String phoneNumber;

  Messagethings({
    required this.senderEmail,
    required this.message,
    required this.receiverId,
    required this.timestamp,
    required this.hotelName,
    required this.phoneNumber,
  }) {
    _initializeUserId();
  }

  Future<void> _initializeUserId() async {
    currentUserId = await _getUserId();
  }

  Future<String> _getUserId() async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-authenticated',
        message: 'User not authenticated',
      );
    }
    return user.uid;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': currentUserId,
      'senderEmail': senderEmail,
      'reciverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'Hotelname': hotelName,
      'phoneNumber': phoneNumber,
      'Replytime': '',
      'Replymessage': '',
    };
  }
}
