import 'package:equatable/equatable.dart';

class SwapWorkdateEntity extends Equatable {
  final String status;
  final String message;
  final List<SwapWorkdateResultEntity>? result;

  const SwapWorkdateEntity({
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

class SwapWorkdateResultEntity extends Equatable {
  final int swapWorkdateId;
  final String swapWorkdateDocumentNumber;
  final String? swapWorkdateRequesterName;
  final String? swapWorkdateProfilePicture;
  final String? swapWorkdateRequesterRole;
  final String swapWorkdateStatus;
  final String swapWorkdateWorkdate;
  final String swapWorkdateNewDate;
  final String swapWorkdateNotes;

  const SwapWorkdateResultEntity({
    required this.swapWorkdateId,
    required this.swapWorkdateDocumentNumber,
    this.swapWorkdateRequesterName,
    this.swapWorkdateProfilePicture,
    this.swapWorkdateRequesterRole,
    required this.swapWorkdateStatus,
    required this.swapWorkdateWorkdate,
    required this.swapWorkdateNewDate,
    required this.swapWorkdateNotes,
  });

  @override
  List<Object?> get props => [
        swapWorkdateId,
        swapWorkdateDocumentNumber,
        swapWorkdateRequesterName,
        swapWorkdateProfilePicture,
        swapWorkdateRequesterRole,
        swapWorkdateStatus,
        swapWorkdateWorkdate,
        swapWorkdateNewDate,
        swapWorkdateNotes,
      ];
}
