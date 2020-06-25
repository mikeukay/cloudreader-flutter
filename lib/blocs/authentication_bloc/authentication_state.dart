import 'package:cloudreader/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  final User user;

  const AuthenticationState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationLoading extends AuthenticationState {
  AuthenticationLoading() : super(null);
}

class AuthenticationSuccess extends AuthenticationState {

  const AuthenticationSuccess(User user) : super(user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AuthenticationSuccess { user: $user }';
}

class AuthenticationFailure extends AuthenticationState {
  AuthenticationFailure() : super(null);
}