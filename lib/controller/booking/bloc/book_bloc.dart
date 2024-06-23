import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  BookBloc() : super(BookInitial()) {
    on<BookEvent>((event, emit) async {
      if (event is BookHotelEvent) {
        await _mapBookHotelEventToState(event.bookingData, emit);
      } else if (event is UpdateBookingEvent) {
        await _mapUpdateBookingEventToState(event, emit);
      } else if (event is DeleteBookingEvent) {
        await _mapDeleteBookingEventToState(event, emit);
      } else if (event is FetchBookingEvent) {
        await _mapFetchBookingEventToState(event, emit);
      }
    });
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

  Future<void> _mapBookHotelEventToState(
      Map<String, dynamic> bookingData, Emitter<BookState> emit) async {
    try {
      emit(BookLoading());
      final String userId = await _getUserId();
      log('Adding hotel booking data for user: $userId');

      final reference = _firestore
          .collection('userSide')
          .doc(userId)
          .collection('bookedhotels');

      final docRef = await reference.add(bookingData);
      log('New booking document ID: ${docRef.id}');

      emit(BookSuccess(docRef.id));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

  Future<void> _mapUpdateBookingEventToState(
      UpdateBookingEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    try {
      String currentUserId = await _getUserId();

      await _firestore
          .collection('userSide')
          .doc(currentUserId)
          .collection('bookedhotels')
          .doc(event.bookingId)
          .update(event.updatedData);

      emit(BookSuccess(event.bookingId));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

  Future<void> _mapDeleteBookingEventToState(
      DeleteBookingEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    try {
      String currentUserId = await _getUserId();

      await _firestore
          .collection('userSide')
          .doc(currentUserId)
          .collection('bookedhotels')
          .doc(event.bookingId)
          .delete();

      emit(BookSuccess(event.bookingId));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

  Future<void> _mapFetchBookingEventToState(
      FetchBookingEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    try {
      String currentUserId = await _getUserId();

      if (event.bookingId == null || event.bookingId!.isEmpty) {
        QuerySnapshot bookingSnapshot = await _firestore
            .collection('userSide')
            .doc(currentUserId)
            .collection('bookedhotels')
            .get();

        if (bookingSnapshot.docs.isEmpty) {
          emit(BookError('No bookings found'));
          return;
        }

        Map<String, dynamic> bookings = {};
        for (var doc in bookingSnapshot.docs) {
          Map<String, dynamic> bookingData = doc.data() as Map<String, dynamic>;
          bookingData['id'] = doc.id;
          bookings[doc.id] = bookingData;
        }

        emit(BookingFetched(bookings));
      } else {
        DocumentSnapshot bookingSnapshot = await _firestore
            .collection('userSide')
            .doc(currentUserId)
            .collection('bookedhotels')
            .doc(event.bookingId)
            .get();

        if (!bookingSnapshot.exists) {
          emit(BookError('Booking not found'));
          return;
        }

        Map<String, dynamic> bookingData =
            bookingSnapshot.data() as Map<String, dynamic>;
        bookingData['id'] = bookingSnapshot.id;

        emit(BookingFetched({event.bookingId!: bookingData}));
      }
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}
