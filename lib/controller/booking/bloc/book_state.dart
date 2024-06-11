part of 'book_bloc.dart';

@immutable
abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookSuccess extends BookState {
  final String docid;
  BookSuccess(this.docid);
}

class BookError extends BookState {
  final String error;

  BookError(this.error);
}

class BookingFetched extends BookState {
  final Map<String, dynamic> bookingData;

  BookingFetched(this.bookingData);
}
