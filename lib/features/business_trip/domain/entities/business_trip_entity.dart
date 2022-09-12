import 'package:equatable/equatable.dart';

class BusinessTripEntity extends Equatable {
  final String status;
  final String message;
  final List<BusinessTripResultEntity>? result;
  final List<dynamic>? types;

  const BusinessTripEntity({
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

class BusinessTripResultEntity extends Equatable {
  final int businessTripId;
  final String businessTripDocumentNumber;
  final String? businessTripRequesterName;
  final String? businessTripProfilePicture;
  final String? businessTripRequesterRole;
  final String businessTripType;
  final String businessTripLocation;
  final String businessTripStatus;
  final String businessTripRequestedDate;
  final String? businessTripDateFrom;
  final String? businessTripDateTo;

  const BusinessTripResultEntity({
    required this.businessTripId,
    required this.businessTripDocumentNumber,
    this.businessTripRequesterName,
    this.businessTripProfilePicture,
    this.businessTripRequesterRole,
    required this.businessTripType,
    required this.businessTripLocation,
    required this.businessTripStatus,
    required this.businessTripRequestedDate,
    this.businessTripDateFrom,
    this.businessTripDateTo,
  });

  @override
  List<Object?> get props => [
        businessTripId,
        businessTripDocumentNumber,
        businessTripRequesterName,
        businessTripProfilePicture,
        businessTripRequesterRole,
        businessTripType,
        businessTripLocation,
        businessTripStatus,
        businessTripRequestedDate,
        businessTripDateFrom,
        businessTripDateTo,
      ];
}
