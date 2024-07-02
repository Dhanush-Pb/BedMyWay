part of 'fetch_msg_bloc.dart';

@immutable
abstract class FetchMsgEvent {}

class FetchMessagesEvent extends FetchMsgEvent {
  FetchMessagesEvent();
}
