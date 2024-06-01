part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class checkloginevern extends AuthEvent {}

// Login event
class Loginevent extends AuthEvent {
  final String email;
  final String password;
  Loginevent({required this.email, required this.password});
}

// Sign up event
class singupevent extends AuthEvent {
  final Usermodel usermodel;
  singupevent(Usermodel user, {required this.usermodel});
}

// Logout event
class logoutevent extends AuthEvent {}

// Forgot password event
class ForgotPasswordEvent extends AuthEvent {
  final String email;
  ForgotPasswordEvent({required this.email});
}
