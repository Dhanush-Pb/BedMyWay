part of 'book_bloc.dart';

@immutable
abstract class BookEvent {}

class BookHotelEvent extends BookEvent {
  final String hotelDocId;
  final Map<String, dynamic> bookingData;

  BookHotelEvent({required this.hotelDocId, required this.bookingData});
}

class UpdateBookingEvent extends BookEvent {
  final String bookingId;
  final Map<String, dynamic> updatedData;

  UpdateBookingEvent({required this.bookingId, required this.updatedData});
}

class DeleteBookingEvent extends BookEvent {
  final String bookingId;

  DeleteBookingEvent({required this.bookingId});
}

class FetchBookingEvent extends BookEvent {
  final String? bookingId;

  FetchBookingEvent({this.bookingId});
}
