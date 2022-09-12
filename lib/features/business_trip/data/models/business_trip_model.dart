import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/business_trip_entity.dart';

part 'business_trip_model.g.dart';

class BusinessTripModel extends BusinessTripEntity {
  const BusinessTripModel({
    required String status,
    required String message,
    List<BusinessTripResultEntity>? result,
    List<dynamic>? types,
  }) : super(
          status: status,
          message: message,
          result: result,
          types: types,
        );

  factory BusinessTripModel.fromJson(Map<String, dynamic> json) =>
      BusinessTripModel(
        status: json['status'],
        message: json['message'],
        result: (json['result'] as List<dynamic>?)
            ?.map((e) =>
                BusinessTripResultModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
        'types': types,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class BusinessTripResultModel extends BusinessTripResultEntity {
  const BusinessTripResultModel({
    required int businessTripId,
    required String businessTripDocumentNumber,
    String? businessTripRequesterName,
    String? businessTripProfilePicture,
    String? businessTripRequesterRole,
    required String businessTripType,
    required String businessTripLocation,
    required String businessTripStatus,
    required String businessTripRequestedDate,
    String? businessTripDateFrom,
    String? businessTripDateTo,
  }) : super(
          businessTripId: businessTripId,
          businessTripDocumentNumber: businessTripDocumentNumber,
          businessTripRequesterName: businessTripRequesterName,
          businessTripProfilePicture: businessTripProfilePicture,
          businessTripRequesterRole: businessTripRequesterRole,
          businessTripType: businessTripType,
          businessTripLocation: businessTripLocation,
          businessTripStatus: businessTripStatus,
          businessTripRequestedDate: businessTripRequestedDate,
          businessTripDateFrom: businessTripDateFrom,
          businessTripDateTo: businessTripDateTo,
        );

  factory BusinessTripResultModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessTripResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessTripResultModelToJson(this);
}
