import 'package:equatable/equatable.dart';

class StaffSignInParams extends Equatable {
  final String username;
  final String password;

  const StaffSignInParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}
