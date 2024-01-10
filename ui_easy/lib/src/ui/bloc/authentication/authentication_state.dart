import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthenticationState {
  final String userEmail;

  const AuthenticatedState({required this.userEmail});

  @override
  List<Object> get props => [userEmail];
}

class UnauthenticatedState extends AuthenticationState {}
