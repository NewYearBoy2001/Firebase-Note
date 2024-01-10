import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthenticationEvent {
  final String email;
  final String user;
  final int age;
  final int phone;
  final String password;
  final String confirmPassword;

  const RegisterEvent({
    required this.email,
    required this.user,
    required this.age,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, user, age, phone, password, confirmPassword];
}
