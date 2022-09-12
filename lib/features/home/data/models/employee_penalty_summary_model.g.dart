// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_penalty_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeePenaltySummaryResultModel _$EmployeePenaltySummaryResultModelFromJson(
        Map<String, dynamic> json) =>
    EmployeePenaltySummaryResultModel(
      summaryPeriod: json['SummaryPeriod'] as String,
      absentCount: json['AbsentCount'] as int,
      forgotClockInCount: json['ForgotClockInCount'] as int,
      forgotClockOutCount: json['ForgotClockOutCount'] as int,
      lateCount: json['LateCount'] as int,
      goEarlyCount: json['GoEarlyCount'] as int,
    );

Map<String, dynamic> _$EmployeePenaltySummaryResultModelToJson(
        EmployeePenaltySummaryResultModel instance) =>
    <String, dynamic>{
      'SummaryPeriod': instance.summaryPeriod,
      'AbsentCount': instance.absentCount,
      'ForgotClockInCount': instance.forgotClockInCount,
      'ForgotClockOutCount': instance.forgotClockOutCount,
      'LateCount': instance.lateCount,
      'GoEarlyCount': instance.goEarlyCount,
    };
