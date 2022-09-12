// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reprimand_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReprimandResultModel _$ReprimandResultModelFromJson(
        Map<String, dynamic> json) =>
    ReprimandResultModel(
      reprimandId: json['ReprimandId'] as int,
      reprimandDocumentNumber: json['ReprimandDocumentNumber'] as String,
      reprimandRequesterName: json['ReprimandRequesterName'] as String?,
      reprimandProfilePicture: json['ReprimandProfilePicture'] as String?,
      reprimandRequesterRole: json['ReprimandRequesterRole'] as String?,
      reprimandStatus: json['ReprimandStatus'] as String,
      reprimandType: json['ReprimandType'] as String,
      reprimandEffectiveDate: json['ReprimandEffectiveDate'] as String,
      reprimandExpirationDate: json['ReprimandExpirationDate'] as String,
      reprimandNotes: json['ReprimandNotes'] as String,
    );

Map<String, dynamic> _$ReprimandResultModelToJson(
        ReprimandResultModel instance) =>
    <String, dynamic>{
      'ReprimandId': instance.reprimandId,
      'ReprimandDocumentNumber': instance.reprimandDocumentNumber,
      'ReprimandRequesterName': instance.reprimandRequesterName,
      'ReprimandProfilePicture': instance.reprimandProfilePicture,
      'ReprimandRequesterRole': instance.reprimandRequesterRole,
      'ReprimandStatus': instance.reprimandStatus,
      'ReprimandType': instance.reprimandType,
      'ReprimandEffectiveDate': instance.reprimandEffectiveDate,
      'ReprimandExpirationDate': instance.reprimandExpirationDate,
      'ReprimandNotes': instance.reprimandNotes,
    };
