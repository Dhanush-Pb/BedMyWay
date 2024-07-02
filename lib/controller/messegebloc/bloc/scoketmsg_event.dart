part of 'scoketmsg_bloc.dart';

@immutable
abstract class ScoketmsgEvent {}

class SendMessageEvent extends ScoketmsgEvent {
  final Messagethings message;

  SendMessageEvent({required this.message});
}

class ReceiveMessageEvent extends ScoketmsgEvent {
  final Messagethings message;

  ReceiveMessageEvent({required this.message});
}
