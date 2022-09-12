import 'package:equatable/equatable.dart';

import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';

class LeaveDetailEntity extends Equatable {
  final String status;
  final String message;
  final LeaveDetailResultEntity result;

  const LeaveDetailEntity({
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

class LeaveDetailResultEntity extends Equatable {
  final int leaveId;
  final String leaveDocumentNumber;
  final String leaveRequesterName;
  final String leaveRequesterProfilePicture;
  final String leaveRequesterRole;
  final String leaveStatus;
  final String leaveRequestDate;
  final String leaveType;
  final String leaveDateFrom;
  final String leaveDateTo;
  final String leaveDuration;
  final String leaveNotes;
  final List<AttachmentEntity> leaveAttachment;
  final List<ApproverEntity> leaveApprover;

  const LeaveDetailResultEntity({
    required this.leaveId,
    required this.leaveDocumentNumber,
    required this.leaveRequesterName,
    required this.leaveRequesterProfilePicture,
    required this.leaveRequesterRole,
    required this.leaveStatus,
    required this.leaveRequestDate,
    required this.leaveType,
    required this.leaveDateFrom,
    required this.leaveDateTo,
    required this.leaveDuration,
    required this.leaveNotes,
    required this.leaveAttachment,
    required this.leaveApprover,
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
        leaveDuration,
        leaveNotes,
        leaveAttachment,
        leaveApprover,
      ];
}
