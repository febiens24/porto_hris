import 'package:equatable/equatable.dart';

import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';

class SwapWorkdateDetailEntity extends Equatable {
  final String status;
  final String message;
  final SwapWorkdateDetailResultEntity result;

  const SwapWorkdateDetailEntity({
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

class SwapWorkdateDetailResultEntity extends Equatable {
  final int swapWorkdateId;
  final String swapWorkdateDocumentNumber;
  final String swapWorkdateRequesterName;
  final String swapWorkdateProfilePicture;
  final String swapWorkdateRequesterRole;
  final String swapWorkdateStatus;
  final String swapWorkdateWorkdate;
  final String swapWorkdateNewDate;
  final String swapWorkdateNotes;
  final List<AttachmentEntity> swapWorkdateAttachments;
  final List<ApproverEntity> swapWorkdateApprovers;

  const SwapWorkdateDetailResultEntity({
    required this.swapWorkdateId,
    required this.swapWorkdateDocumentNumber,
    required this.swapWorkdateRequesterName,
    required this.swapWorkdateProfilePicture,
    required this.swapWorkdateRequesterRole,
    required this.swapWorkdateStatus,
    required this.swapWorkdateWorkdate,
    required this.swapWorkdateNewDate,
    required this.swapWorkdateNotes,
    required this.swapWorkdateAttachments,
    required this.swapWorkdateApprovers,
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
        swapWorkdateAttachments,
        swapWorkdateApprovers,
      ];
}
