part of 'hoteldata_bloc.dart';

@immutable
sealed class HoteldataState {}

final class HoteldataInitial extends HoteldataState {}

class HoteldataLoading extends HoteldataState {}

class Hoteldataloading extends HoteldataState {}

class HotelDatafetched extends HoteldataState {
  final List<Map<String, dynamic>> hotels;
  HotelDatafetched({required this.hotels});
}

class HotelDataerror extends HoteldataState {
  final String error;
  HotelDataerror({required this.error});
}
