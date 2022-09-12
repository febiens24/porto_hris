import 'package:equatable/equatable.dart';

class DispensationEntity extends Equatable {
  final String status;
  final String message;
  final List<DispensationResultEntity> result;
  final List<dynamic>? types;

  const DispensationEntity({
    required this.status,
    required this.message,
    required this.result,
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

class DispensationResultEntity extends Equatable {
  final int dispensationId;
  final String dispensationDocumentNumber;
  final String? dispensationRequesterName;
  final String? dispensationRequesterProfilePicture;
  final String? dispensationRequesterRole;
  final String dispensationStatus;
  final String dispensationRequestDate;
  final String dispensationType;
  final String? dispensationClockType;
  final String dispensationDate;

  const DispensationResultEntity({
    required this.dispensationId,
    required this.dispensationDocumentNumber,
    this.dispensationRequesterName,
    this.dispensationRequesterProfilePicture,
    this.dispensationRequesterRole,
    required this.dispensationStatus,
    required this.dispensationRequestDate,
    required this.dispensationType,
    this.dispensationClockType,
    required this.dispensationDate,
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
        dispensationClockType,
        dispensationDate,
      ];
}
