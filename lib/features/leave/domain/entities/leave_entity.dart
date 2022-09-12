import 'package:equatable/equatable.dart';

class LeaveEntity extends Equatable {
  final String status;
  final String message;
  final List<LeaveResultEntity>? result;
  final List<dynamic>? types;

  const LeaveEntity({
    required this.status,
    required this.message,
    this.result,
    this.types,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        result,
        types,
      ];
}

class LeaveResultEntity extends Equatable {
  final int leaveId;
  final String leaveDocumentNumber;
  final String? leaveRequesterName;
  final String? leaveRequesterProfilePicture;
  final String? leaveRequesterRole;
  final String leaveStatus;
  final String leaveRequestDate;
  final String leaveType;
  final String leaveDateFrom;
  final String leaveDateTo;

  const LeaveResultEntity({
    required this.leaveId,
    required this.leaveDocumentNumber,
    this.leaveRequesterName,
    this.leaveRequesterProfilePicture,
    this.leaveRequesterRole,
    required this.leaveStatus,
    required this.leaveRequestDate,
    required this.leaveType,
    required this.leaveDateFrom,
    required this.leaveDateTo,
  });

  @override
  List<Object?> get props => [
        leaveId,
        leaveDocumentNumber,
        leaveRequesterName,
        leaveRequesterProfilePicture,
        leaveRequesterRole,
        leaveStatus,
        leaveRequestDate,
        leaveType,
        leaveDateFrom,
        leaveDateTo,
      ];
}
