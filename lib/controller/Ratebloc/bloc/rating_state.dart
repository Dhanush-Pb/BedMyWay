part of 'rating_bloc.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}

class HotelRatingdataLoading extends RatingState {}

class Ratingdatafetched extends RatingState {
  final List<Map<String, dynamic>> hotels;
  Ratingdatafetched({required this.hotels});
}

class RatingDataerror extends RatingState {
  final String error;
  RatingDataerror({required this.error});
}
