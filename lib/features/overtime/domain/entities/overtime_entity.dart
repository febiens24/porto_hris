import 'package:equatable/equatable.dart';

class OvertimeEntity extends Equatable {
  final String status;
  final String message;
  final List<OvertimeResultEntity>? result;
  final List<dynamic>? types;

  const OvertimeEntity({
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

class OvertimeResultEntity extends Equatable {
  final int overtimeId;
  final String overtimeDocumentNumber;
  final String? overtimeRequesterName;
  final String? overtimeProfilePicture;
  final String? overtimeRequesterRole;
  final String overtimeRequestedDate;
  final String overtimeType;
  final String overtimeStatus;
  final String? overtimeDateFrom;
  final String? overtimeDateTo;

  const OvertimeResultEntity({
    required this.overtimeId,
    required this.overtimeDocumentNumber,
    this.overtimeRequesterName,
    this.overtimeProfilePicture,
    this.overtimeRequesterRole,
    required this.overtimeRequestedDate,
    required this.overtimeType,
    required this.overtimeStatus,
    this.overtimeDateFrom,
    this.overtimeDateTo,
  });

  @override
  List<Object?> get props => [
        overtimeId,
        overtimeDocumentNumber,
        overtimeRequesterName,
        overtimeProfilePicture,
        overtimeRequesterRole,
        overtimeRequestedDate,
        overtimeType,
        overtimeStatus,
        overtimeDateFrom,
        overtimeDateTo,
      ];
}
