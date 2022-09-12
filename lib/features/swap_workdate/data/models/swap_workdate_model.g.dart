// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap_workdate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwapWorkdateResultModel _$SwapWorkdateResultModelFromJson(
        Map<String, dynamic> json) =>
    SwapWorkdateResultModel(
      swapWorkdateId: json['SwapWorkdateId'] as int,
      swapWorkdateDocumentNumber: json['SwapWorkdateDocumentNumber'] as String,
      swapWorkdateRequesterName: json['SwapWorkdateRequesterName'] as String?,
      swapWorkdateProfilePicture: json['SwapWorkdateProfilePicture'] as String?,
      swapWorkdateRequesterRole: json['SwapWorkdateRequesterRole'] as String?,
      swapWorkdateStatus: json['SwapWorkdateStatus'] as String,
      swapWorkdateWorkdate: json['SwapWorkdateWorkdate'] as String,
      swapWorkdateNewDate: json['SwapWorkdateNewDate'] as String,
      swapWorkdateNotes: json['SwapWorkdateNotes'] as String,
    );

Map<String, dynamic> _$SwapWorkdateResultModelToJson(
        SwapWorkdateResultModel instance) =>
    <String, dynamic>{
      'SwapWorkdateId': instance.swapWorkdateId,
      'SwapWorkdateDocumentNumber': instance.swapWorkdateDocumentNumber,
      'SwapWorkdateRequesterName': instance.swapWorkdateRequesterName,
      'SwapWorkdateProfilePicture': instance.swapWorkdateProfilePicture,
      'SwapWorkdateRequesterRole': instance.swapWorkdateRequesterRole,
      'SwapWorkdateStatus': instance.swapWorkdateStatus,
      'SwapWorkdateWorkdate': instance.swapWorkdateWorkdate,
      'SwapWorkdateNewDate': instance.swapWorkdateNewDate,
      'SwapWorkdateNotes': instance.swapWorkdateNotes,
    };
