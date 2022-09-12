part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInComplete extends SignInState {
  final String user;

  const SignInComplete(this.user);

  @override
  List<Object> get props => [user];
}

class SignInFailure extends SignInState {
  final UserErrorEntity error;

  const SignInFailure(this.error);

  @override
  List<Object> get props => [error];
}
