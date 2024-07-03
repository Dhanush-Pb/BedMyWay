import 'package:bedmyway/Model/Messege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(Messagethings message) async {
    try {
      final String currentUserId = await _getUserId();

      final reference = _firestore
          .collection('userSide')
          .doc(currentUserId)
          .collection('messeges');
      await reference.add(message.toMap());
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<void> storeReceivedMessage(Messagethings message) async {
    try {
      final String currentUserId = await _getUserId();

      final reference = _firestore
          .collection('userSide')
          .doc(currentUserId)
          .collection('messeges');
      await reference.add(message.toMap());
    } catch (e) {
      throw Exception('Failed to store received message: $e');
    }
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
}
