import 'package:equatable/equatable.dart';

import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';

class BusinessTripDetailEntity extends Equatable {
  final String status;
  final String message;
  final BusinessTripDetailResultEntity result;

  const BusinessTripDetailEntity({
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

class BusinessTripDetailResultEntity extends Equatable {
  final int businessTripId;
  final String businessTripDocumentNumber;
  final String businessTripRequesterName;
  final String businessTripProfilePicture;
  final String businessTripRequesterRole;
  final String businessTripStatus;
  final String businessTripRequestedDate;
  final String businessTripType;
  final String businessTripStartDate;
  final String businessTripEndDate;
  final String businessTripDuration;
  final String businessTripLocation;
  final String businessTripNotes;
  final List<AttachmentEntity> businessTripAttachments;
  final List<ApproverEntity> businessTripApprovers;

  const BusinessTripDetailResultEntity({
    required this.businessTripId,
    required this.businessTripDocumentNumber,
    required this.businessTripRequesterName,
    required this.businessTripProfilePicture,
    required this.businessTripRequesterRole,
    required this.businessTripStatus,
    required this.businessTripRequestedDate,
    required this.businessTripType,
    required this.businessTripStartDate,
    required this.businessTripEndDate,
    required this.businessTripDuration,
    required this.businessTripLocation,
    required this.businessTripNotes,
    required this.businessTripAttachments,
    required this.businessTripApprovers,
  });

  @override
  List<Object?> get props => [
        businessTripId,
        businessTripDocumentNumber,
        businessTripRequesterName,
        businessTripProfilePicture,
        businessTripRequesterRole,
        businessTripStatus,
        businessTripRequestedDate,
        businessTripType,
        businessTripStartDate,
        businessTripEndDate,
        businessTripDuration,
        businessTripLocation,
        businessTripNotes,
        businessTripAttachments,
        businessTripApprovers,
      ];
}
