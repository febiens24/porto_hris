part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationComplete extends AuthenticationState {
  final String userId;

  const AuthenticationComplete(this.userId);

  @override
  List<Object> get props => [userId];
}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {
  final bool? introductionStatus;

  const AuthenticationUnauthenticated({this.introductionStatus});

  @override
  List<Object> get props => [introductionStatus!];
}
