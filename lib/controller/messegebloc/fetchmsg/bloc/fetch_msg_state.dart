part of 'fetch_msg_bloc.dart';

@immutable
abstract class FetchMsgState {}

class FetchMsgInitial extends FetchMsgState {}

class FetchMsgLoading extends FetchMsgState {}

class FetchMsgSuccess extends FetchMsgState {
  final List<Map<String, dynamic>> messages;

  FetchMsgSuccess(this.messages);
}

class FetchMsgFailure extends FetchMsgState {
  final String error;

  FetchMsgFailure(this.error);
}
