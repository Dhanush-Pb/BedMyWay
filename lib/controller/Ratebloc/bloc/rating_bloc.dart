// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RatingBloc() : super(RatingInitial()) {
    on<RatingEvent>((event, emit) async {
      if (event is FetchRatingdataEvent) {
        await _getHotelRatingData(emit);
      }
    });
  }

  Future<void> _getHotelRatingData(Emitter<RatingState> emit) async {
    emit(HotelRatingdataLoading());
    try {
      QuerySnapshot userSnapshot =
          await _firestore.collection('userSide').get();

      List<Map<String, dynamic>> hotels = [];

      for (var userDoc in userSnapshot.docs) {
        QuerySnapshot hotelSnapshot = await _firestore
            .collection('userSide')
            .doc(userDoc.id)
            .collection('bookedhotels')
            .get();

        for (var hotelDoc in hotelSnapshot.docs) {
          Map<String, dynamic> data = hotelDoc.data() as Map<String, dynamic>;
          // data['id'] = hotelDoc.id;
          hotels.add(data);
        }
      }

      if (hotels.isNotEmpty) {
        emit(Ratingdatafetched(hotels: hotels));
      } else {
        emit(RatingDataerror(error: 'No hotel data found'));
      }
    } catch (e) {
      emit(RatingDataerror(error: e.toString()));
    }
  }
}
