// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_attendance_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeAttendanceSummaryResultModel
    _$EmployeeAttendanceSummaryResultModelFromJson(Map<String, dynamic> json) =>
        EmployeeAttendanceSummaryResultModel(
          summaryPeriod: json['SummaryPeriod'] as String,
          attendanceCount: json['AttendanceCount'] as int,
          sickCount: json['SickCount'] as int,
          leaveCount: json['LeaveCount'] as int,
          dispensationCount: json['DispensationCount'] as int,
        );

Map<String, dynamic> _$EmployeeAttendanceSummaryResultModelToJson(
        EmployeeAttendanceSummaryResultModel instance) =>
    <String, dynamic>{
      'SummaryPeriod': instance.summaryPeriod,
      'AttendanceCount': instance.attendanceCount,
      'SickCount': instance.sickCount,
      'LeaveCount': instance.leaveCount,
      'DispensationCount': instance.dispensationCount,
    };
