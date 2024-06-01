part of 'hoteldata_bloc.dart';

@immutable
sealed class HoteldataEvent {}

class FetchdataEvent extends HoteldataEvent {}
