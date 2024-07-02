part of 'scoketmsg_bloc.dart';

@immutable
abstract class ScoketmsgState {}

class ScoketmsgInitial extends ScoketmsgState {}

class SendMessageSuccessState extends ScoketmsgState {}

class SendMessageFailureState extends ScoketmsgState {
  final String error;

  SendMessageFailureState({required this.error});
}

class ReceiveMessageSuccessState extends ScoketmsgState {}

class ReceiveMessageFailureState extends ScoketmsgState {
  final String error;

  ReceiveMessageFailureState({required this.error});
}
