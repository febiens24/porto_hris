// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_types_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypesResultModel _$LeaveTypesResultModelFromJson(
        Map<String, dynamic> json) =>
    LeaveTypesResultModel(
      leaveType: json['LeaveType'] as String,
      leaveBalance: (json['LeaveBalance'] as num).toDouble(),
      isHalfdayAllowed: json['IsHalfdayAllowed'] as bool,
    );

Map<String, dynamic> _$LeaveTypesResultModelToJson(
        LeaveTypesResultModel instance) =>
    <String, dynamic>{
      'LeaveType': instance.leaveType,
      'LeaveBalance': instance.leaveBalance,
      'IsHalfdayAllowed': instance.isHalfdayAllowed,
    };
