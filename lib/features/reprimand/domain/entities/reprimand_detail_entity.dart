import 'package:equatable/equatable.dart';

import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';

class ReprimandDetailEntity extends Equatable {
  final String status;
  final String message;
  final ReprimandDetailResultEntity result;

  const ReprimandDetailEntity({
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

class ReprimandDetailResultEntity extends Equatable {
  final int reprimandId;
  final String reprimandNumber;
  final String reprimandRequesterName;
  final String reprimandProfilePicture;
  final String reprimandRequesterRole;
  final String reprimandStatus;
  final String reprimandType;
  final String reprimandEffectiveDate;
  final String reprimandExpirationDate;
  final String reprimandNotes;
  final List<AttachmentEntity> reprimandAttachments;
  final List<ApproverEntity> reprimandApprovers;

  const ReprimandDetailResultEntity({
    required this.reprimandId,
    required this.reprimandNumber,
    required this.reprimandRequesterName,
    required this.reprimandProfilePicture,
    required this.reprimandRequesterRole,
    required this.reprimandStatus,
    required this.reprimandType,
    required this.reprimandEffectiveDate,
    required this.reprimandExpirationDate,
    required this.reprimandNotes,
    required this.reprimandAttachments,
    required this.reprimandApprovers,
  });

  @override
  List<Object?> get props => [
        reprimandId,
        reprimandNumber,
        reprimandRequesterName,
        reprimandProfilePicture,
        reprimandRequesterRole,
        reprimandStatus,
        reprimandType,
        reprimandEffectiveDate,
        reprimandExpirationDate,
        reprimandNotes,
        reprimandAttachments,
        reprimandApprovers,
      ];
}
