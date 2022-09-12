part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class AuthenticationLogin extends AuthenticationEvent {
  final String user;

  const AuthenticationLogin(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class SaveIntroductionState extends AuthenticationEvent {
  final bool isSeen;

  const SaveIntroductionState(this.isSeen);

  @override
  List<Object> get props => [isSeen];
}
