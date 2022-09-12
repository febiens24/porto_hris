// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approvals_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalsResultModel _$ApprovalsResultModelFromJson(
        Map<String, dynamic> json) =>
    ApprovalsResultModel(
      attendanceCount: json['AttendanceCount'] as int,
      leaveCount: json['LeaveCount'] as int,
      businessTripCount: json['BusinessTripCount'] as int,
      overtimeCount: json['OvertimeCount'] as int,
      dispensationCount: json['DispensationCount'] as int,
      swapWorkdateCount: json['SwapWorkdateCount'] as int,
      reprimandCount: json['ReprimandCount'] as int,
    );

Map<String, dynamic> _$ApprovalsResultModelToJson(
        ApprovalsResultModel instance) =>
    <String, dynamic>{
      'AttendanceCount': instance.attendanceCount,
      'LeaveCount': instance.leaveCount,
      'BusinessTripCount': instance.businessTripCount,
      'OvertimeCount': instance.overtimeCount,
      'DispensationCount': instance.dispensationCount,
      'SwapWorkdateCount': instance.swapWorkdateCount,
      'ReprimandCount': instance.reprimandCount,
    };
