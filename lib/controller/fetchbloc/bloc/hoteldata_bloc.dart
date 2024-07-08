// ignore_for_file: unused_field, depend_on_referenced_packages

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'hoteldata_event.dart';
part 'hoteldata_state.dart';

class HoteldataBloc extends Bloc<HoteldataEvent, HoteldataState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  HoteldataBloc() : super(HoteldataInitial()) {
    on<HoteldataEvent>((event, emit) async {
      if (event is FetchdataEvent) {
        await _getHotelData(emit);
      }
    });
  }

  Future<void> _getHotelData(Emitter<HoteldataState> emit) async {
    log('Fetching hotel data...');
    emit(Hoteldataloading());
    try {
      QuerySnapshot userSnapshot = await _firestore.collection('users').get();

      List<Map<String, dynamic>> hotels = [];

      for (var userDoc in userSnapshot.docs) {
        QuerySnapshot hotelSnapshot = await _firestore
            .collection('users')
            .doc(userDoc.id)
            .collection('hoteldata')
            .get();

        for (var hotelDoc in hotelSnapshot.docs) {
          Map<String, dynamic> data = hotelDoc.data() as Map<String, dynamic>;
          data['id'] = hotelDoc.id;
          hotels.add(data);
        }
      }

      if (hotels.isNotEmpty) {
        emit(HotelDatafetched(hotels: hotels));
      } else {
        emit(HotelDataerror(error: 'No hotel data found'));
      }
    } catch (e) {
      emit(HotelDataerror(error: e.toString()));
    }
  }
}
