// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overtime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OvertimeResultModel _$OvertimeResultModelFromJson(Map<String, dynamic> json) =>
    OvertimeResultModel(
      overtimeId: json['OvertimeId'] as int,
      overtimeDocumentNumber: json['OvertimeDocumentNumber'] as String,
      overtimeRequesterName: json['OvertimeRequesterName'] as String?,
      overtimeProfilePicture: json['OvertimeProfilePicture'] as String?,
      overtimeRequesterRole: json['OvertimeRequesterRole'] as String?,
      overtimeRequestedDate: json['OvertimeRequestedDate'] as String,
      overtimeType: json['OvertimeType'] as String,
      overtimeStatus: json['OvertimeStatus'] as String,
      overtimeDateFrom: json['OvertimeDateFrom'] as String?,
      overtimeDateTo: json['OvertimeDateTo'] as String?,
    );

Map<String, dynamic> _$OvertimeResultModelToJson(
        OvertimeResultModel instance) =>
    <String, dynamic>{
      'OvertimeId': instance.overtimeId,
      'OvertimeDocumentNumber': instance.overtimeDocumentNumber,
      'OvertimeRequesterName': instance.overtimeRequesterName,
      'OvertimeProfilePicture': instance.overtimeProfilePicture,
      'OvertimeRequesterRole': instance.overtimeRequesterRole,
      'OvertimeRequestedDate': instance.overtimeRequestedDate,
      'OvertimeType': instance.overtimeType,
      'OvertimeStatus': instance.overtimeStatus,
      'OvertimeDateFrom': instance.overtimeDateFrom,
      'OvertimeDateTo': instance.overtimeDateTo,
    };
