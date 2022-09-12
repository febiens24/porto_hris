import 'package:equatable/equatable.dart';

import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';

class AttendanceDetailEntity extends Equatable {
  final String status;
  final String message;
  final AttendanceDetailResultEntity result;

  const AttendanceDetailEntity({
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

class AttendanceDetailResultEntity extends Equatable {
  final int attendanceId;
  final String attendanceDocumentNumber;
  final String attendanceRequesterName;
  final String attendanceRequesterProfilePicture;
  final String attendanceRequesterRole;
  final String attendanceStatus;
  final String attendanceDateTime;
  final String attendanceType;
  final String attendanceMode;
  final String attendanceNotes;
  final String attendanceCoordinates;
  final List<AttachmentEntity> attendanceAttachments;
  final List<ApproverEntity> attendanceApprovers;

  const AttendanceDetailResultEntity({
    required this.attendanceId,
    required this.attendanceDocumentNumber,
    required this.attendanceRequesterName,
    required this.attendanceRequesterProfilePicture,
    required this.attendanceRequesterRole,
    required this.attendanceStatus,
    required this.attendanceDateTime,
    required this.attendanceType,
    required this.attendanceMode,
    required this.attendanceNotes,
    required this.attendanceCoordinates,
    required this.attendanceAttachments,
    required this.attendanceApprovers,
  });

  @override
  List<Object?> get props => [
        attendanceId,
        attendanceDocumentNumber,
        attendanceRequesterName,
        attendanceRequesterProfilePicture,
        attendanceRequesterRole,
        attendanceStatus,
        attendanceDateTime,
        attendanceType,
        attendanceMode,
        attendanceNotes,
        attendanceCoordinates,
        attendanceAttachments,
        attendanceApprovers,
      ];
}