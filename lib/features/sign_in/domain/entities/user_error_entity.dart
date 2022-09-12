import 'package:equatable/equatable.dart';

class UserErrorEntity extends Equatable {
  final String status;
  final String? result;

  const UserErrorEntity({
    required this.status,
    required this.result,
  });

  @override
  List<Object?> get props => [
        status,
        result,
      ];
}
