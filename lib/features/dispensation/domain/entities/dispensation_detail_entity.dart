import 'package:equatable/equatable.dart';

import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';

class DispensationDetailEntity extends Equatable {
  final String status;
  final String message;
  final DispensationDetailResultEntity result;

  const DispensationDetailEntity({
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

class DispensationDetailResultEntity extends Equatable {
  final int dispensationId;
  final String dispensationDocumentNumber;
  final String dispensationRequesterName;
  final String dispensationRequesterProfilePicture;
  final String dispensationRequesterRole;
  final String dispensationStatus;
  final String dispensationRequestDate;
  final String dispensationType;
  final String dispensationDate;
  final String dispensationClockType;
  final String dispensationNotes;
  final List<AttachmentEntity> dispensationAttachments;
  final List<ApproverEntity> dispensationApprovers;

  const DispensationDetailResultEntity({
    required this.dispensationId,
    required this.dispensationDocumentNumber,
    required this.dispensationRequesterName,
    required this.dispensationRequesterProfilePicture,
    required this.dispensationRequesterRole,
    required this.dispensationStatus,
    required this.dispensationRequestDate,
    required this.dispensationType,
    required this.dispensationDate,
    required this.dispensationClockType,
    required this.dispensationNotes,
    required this.dispensationAttachments,
    required this.dispensationApprovers,
  });

  @override
  List<Object?> get props => [
        dispensationId,
        dispensationDocumentNumber,
        dispensationRequesterName,
        dispensationRequesterProfilePicture,
        dispensationRequesterRole,
        dispensationStatus,
        dispensationRequestDate,
        dispensationType,
        dispensationDate,
        dispensationClockType,
        dispensationNotes,
        dispensationAttachments,
        dispensationApprovers,
      ];
}
