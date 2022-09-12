import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final String status;
  final String message;
  final List<AttendanceResultEntity>? result;

  const AttendanceEntity({
    required this.status,
    required this.message,
    this.result,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        result,
      ];
}

class AttendanceResultEntity extends Equatable {
  final int attendanceId;
  final String attendanceDocumentNumber;
  final String? attendanceRequesterName;
  final String? attendanceRequesterProfilePicture;
  final String? attendanceRequesterRole;
  final String attendanceStatus;
  final String attendanceDateTime;
  final String attendanceType;
  final String attendanceMode;
  final String attendanceNotes;
  // final List<AttachmentEntity>? attendanceAttachments;

  const AttendanceResultEntity({
    required this.attendanceId,
    required this.attendanceDocumentNumber,
    this.attendanceRequesterName,
    this.attendanceRequesterProfilePicture,
    this.attendanceRequesterRole,
    required this.attendanceStatus,
    required this.attendanceDateTime,
    required this.attendanceType,
    required this.attendanceMode,
    required this.attendanceNotes,
    // this.attendanceAttachments,
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
        // attendanceAttachments,
      ];
}
