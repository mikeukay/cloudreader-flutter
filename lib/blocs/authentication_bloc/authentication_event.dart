import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitialize extends AuthenticationEvent {}

class AuthenticationSignInWithGoogleButtonPressed extends AuthenticationEvent {}

class AuthenticationLogOut extends AuthenticationEvent {}