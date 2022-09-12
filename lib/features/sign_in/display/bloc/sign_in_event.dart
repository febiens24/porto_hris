part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInUser extends SignInEvent {
  final String username;
  final String password;

  const SignInUser({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
