// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessTripResultModel _$BusinessTripResultModelFromJson(
        Map<String, dynamic> json) =>
    BusinessTripResultModel(
      businessTripId: json['BusinessTripId'] as int,
      businessTripDocumentNumber: json['BusinessTripDocumentNumber'] as String,
      businessTripRequesterName: json['BusinessTripRequesterName'] as String?,
      businessTripProfilePicture: json['BusinessTripProfilePicture'] as String?,
      businessTripRequesterRole: json['BusinessTripRequesterRole'] as String?,
      businessTripType: json['BusinessTripType'] as String,
      businessTripLocation: json['BusinessTripLocation'] as String,
      businessTripStatus: json['BusinessTripStatus'] as String,
      businessTripRequestedDate: json['BusinessTripRequestedDate'] as String,
      businessTripDateFrom: json['BusinessTripDateFrom'] as String?,
      businessTripDateTo: json['BusinessTripDateTo'] as String?,
    );

Map<String, dynamic> _$BusinessTripResultModelToJson(
        BusinessTripResultModel instance) =>
    <String, dynamic>{
      'BusinessTripId': instance.businessTripId,
      'BusinessTripDocumentNumber': instance.businessTripDocumentNumber,
      'BusinessTripRequesterName': instance.businessTripRequesterName,
      'BusinessTripProfilePicture': instance.businessTripProfilePicture,
      'BusinessTripRequesterRole': instance.businessTripRequesterRole,
      'BusinessTripType': instance.businessTripType,
      'BusinessTripLocation': instance.businessTripLocation,
      'BusinessTripStatus': instance.businessTripStatus,
      'BusinessTripRequestedDate': instance.businessTripRequestedDate,
      'BusinessTripDateFrom': instance.businessTripDateFrom,
      'BusinessTripDateTo': instance.businessTripDateTo,
    };
