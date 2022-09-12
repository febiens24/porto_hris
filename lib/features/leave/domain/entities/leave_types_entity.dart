import 'package:equatable/equatable.dart';

class LeaveTypesEntity extends Equatable {
  final String status;
  final String message;
  final List<LeaveTypeResultEntity> result;

  const LeaveTypesEntity({
    required this.status,
    required this.message,
    required this.result,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        result,
      ];
}

class LeaveTypeResultEntity extends Equatable {
  final String leaveType;
  final double leaveBalance;
  final bool isHalfdayAllowed;

  const LeaveTypeResultEntity({
    required this.leaveType,
    required this.leaveBalance,
    required this.isHalfdayAllowed,
  });

  @override
  List<Object?> get props => [
        leaveType,
        leaveBalance,
        isHalfdayAllowed,
      ];
}
