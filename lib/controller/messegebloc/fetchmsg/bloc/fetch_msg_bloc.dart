// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'fetch_msg_event.dart';
part 'fetch_msg_state.dart';

class FetchMsgBloc extends Bloc<FetchMsgEvent, FetchMsgState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FetchMsgBloc() : super(FetchMsgInitial()) {
    on<FetchMessagesEvent>(_onFetchMessages);
  }

  Future<void> _onFetchMessages(
      FetchMessagesEvent event, Emitter<FetchMsgState> emit) async {
    emit(FetchMsgLoading());
    try {
      //  print('Fetching messages...');
      String userId = await _getUserId();
      QuerySnapshot messageSnapshot = await _firestore
          .collection('userSide')
          .doc(userId)
          .collection('messeges')
          .get();

      Set<String> seenHotelIds = {}; // Track seen hotelIds
      List<Map<String, dynamic>> messages = [];

      for (var messageDoc in messageSnapshot.docs) {
        Map<String, dynamic> data = messageDoc.data() as Map<String, dynamic>;
        data['id'] = messageDoc.id;

        String hotelId = data['reciverId'];

        if (!seenHotelIds.contains(hotelId)) {
          messages.add(data);
          seenHotelIds.add(hotelId);
          log(data.toString());
        }
      }

      if (messages.isNotEmpty) {
        emit(FetchMsgSuccess(messages.toSet().toList()));
      } else {
        emit(FetchMsgFailure('No messages found for user'));
      }
    } catch (e) {
      //print('Error fetching messages: $e');
      emit(FetchMsgFailure(e.toString()));
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
