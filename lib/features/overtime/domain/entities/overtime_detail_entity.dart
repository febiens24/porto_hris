import 'package:equatable/equatable.dart';

import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';

class OvertimeDetailEntity extends Equatable {
  final String status;
  final String message;
  final OvertimeDetailResultEntity result;

  const OvertimeDetailEntity({
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

class OvertimeDetailResultEntity extends Equatable {
  final int overtimeId;
  final String overtimeDocumentNumber;
  final String overtimeRequesterName;
  final String overtimeProfilePicture;
  final String overtimeRequesterRole;
  final String overtimeRequestDate;
  final String overtimeType;
  final String overtimeStatus;
  final String overtimeStartDate;
  final String overtimeEndDate;
  final String overtimeDuration;
  final String overtimeNotes;
  final List<AttachmentEntity> overtimeAttachments;
  final List<ApproverEntity> overtimeApprovers;

  const OvertimeDetailResultEntity({
    required this.overtimeId,
    required this.overtimeDocumentNumber,
    required this.overtimeRequesterName,
    required this.overtimeProfilePicture,
    required this.overtimeRequesterRole,
    required this.overtimeRequestDate,
    required this.overtimeType,
    required this.overtimeStatus,
    required this.overtimeStartDate,
    required this.overtimeEndDate,
    required this.overtimeDuration,
    required this.overtimeNotes,
    required this.overtimeAttachments,
    required this.overtimeApprovers,
  });

  @override
  List<Object?> get props => [
        overtimeId,
        overtimeDocumentNumber,
        overtimeRequesterName,
        overtimeProfilePicture,
        overtimeRequesterRole,
        overtimeRequestDate,
        overtimeType,
        overtimeStatus,
        overtimeStartDate,
        overtimeEndDate,
        overtimeDuration,
        overtimeNotes,
        overtimeAttachments,
        overtimeApprovers,
      ];
}
