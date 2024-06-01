part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class Authloadin extends AuthState {}

// ignore: must_be_immutable
class Authenticated extends AuthState {
  String user;
  Authenticated(this.user);

  get usermodel => null;
}

class AuthenticateError extends AuthState {
  final String messege;
  AuthenticateError(this.messege);
}

class UnAuthenticated extends AuthState {}
