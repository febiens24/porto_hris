import 'package:equatable/equatable.dart';

class ReprimandEntity extends Equatable {
  final String status;
  final String message;
  final List<ReprimandResultEntity>? result;
  final List<dynamic>? types;

  const ReprimandEntity({
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

class ReprimandResultEntity extends Equatable {
  final int reprimandId;
  final String reprimandDocumentNumber;
  final String? reprimandRequesterName;
  final String? reprimandProfilePicture;
  final String? reprimandRequesterRole;
  final String reprimandStatus;
  final String reprimandType;
  final String reprimandEffectiveDate;
  final String reprimandExpirationDate;
  final String reprimandNotes;

  const ReprimandResultEntity({
    required this.reprimandId,
    required this.reprimandDocumentNumber,
    this.reprimandRequesterName,
    this.reprimandProfilePicture,
    this.reprimandRequesterRole,
    required this.reprimandStatus,
    required this.reprimandType,
    required this.reprimandEffectiveDate,
    required this.reprimandExpirationDate,
    required this.reprimandNotes,
  });

  @override
  List<Object?> get props => [
        reprimandId,
        reprimandDocumentNumber,
        reprimandRequesterName,
        reprimandProfilePicture,
        reprimandRequesterRole,
        reprimandStatus,
        reprimandType,
        reprimandEffectiveDate,
        reprimandExpirationDate,
        reprimandNotes,
      ];
}
