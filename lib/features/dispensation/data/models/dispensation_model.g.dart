// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispensation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DispensationResultModel _$DispensationResultModelFromJson(
        Map<String, dynamic> json) =>
    DispensationResultModel(
      dispensationId: json['DispensationId'] as int,
      dispensationDocumentNumber: json['DispensationDocumentNumber'] as String,
      dispensationRequesterName: json['DispensationRequesterName'] as String?,
      dispensationRequesterProfilePicture:
          json['DispensationRequesterProfilePicture'] as String?,
      dispensationRequesterRole: json['DispensationRequesterRole'] as String?,
      dispensationStatus: json['DispensationStatus'] as String,
      dispensationRequestDate: json['DispensationRequestDate'] as String,
      dispensationType: json['DispensationType'] as String,
      dispensationClockType: json['DispensationClockType'] as String?,
      dispensationDate: json['DispensationDate'] as String,
    );

Map<String, dynamic> _$DispensationResultModelToJson(
        DispensationResultModel instance) =>
    <String, dynamic>{
      'DispensationId': instance.dispensationId,
      'DispensationDocumentNumber': instance.dispensationDocumentNumber,
      'DispensationRequesterName': instance.dispensationRequesterName,
      'DispensationRequesterProfilePicture':
          instance.dispensationRequesterProfilePicture,
      'DispensationRequesterRole': instance.dispensationRequesterRole,
      'DispensationStatus': instance.dispensationStatus,
      'DispensationRequestDate': instance.dispensationRequestDate,
      'DispensationType': instance.dispensationType,
      'DispensationClockType': instance.dispensationClockType,
      'DispensationDate': instance.dispensationDate,
    };
