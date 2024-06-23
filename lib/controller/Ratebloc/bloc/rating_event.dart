part of 'rating_bloc.dart';

@immutable
sealed class RatingEvent {}

class FetchRatingdataEvent extends RatingEvent {}
