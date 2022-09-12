// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceResultModel _$AttendanceResultModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceResultModel(
      attendanceId: json['AttendanceId'] as int,
      attendanceDocumentNumber: json['AttendanceDocumentNumber'] as String,
      attendanceRequesterName: json['AttendanceRequesterName'] as String?,
      attendanceRequesterProfilePicture:
          json['AttendanceRequesterProfilePicture'] as String?,
      attendanceRequesterRole: json['AttendanceRequesterRole'] as String?,
      attendanceStatus: json['AttendanceStatus'] as String,
      attendanceDateTime: json['AttendanceDateTime'] as String,
      attendanceType: json['AttendanceType'] as String,
      attendanceMode: json['AttendanceMode'] as String,
      attendanceNotes: json['AttendanceNotes'] as String,
    );

Map<String, dynamic> _$AttendanceResultModelToJson(
        AttendanceResultModel instance) =>
    <String, dynamic>{
      'AttendanceId': instance.attendanceId,
      'AttendanceDocumentNumber': instance.attendanceDocumentNumber,
      'AttendanceRequesterName': instance.attendanceRequesterName,
      'AttendanceRequesterProfilePicture':
          instance.attendanceRequesterProfilePicture,
      'AttendanceRequesterRole': instance.attendanceRequesterRole,
      'AttendanceStatus': instance.attendanceStatus,
      'AttendanceDateTime': instance.attendanceDateTime,
      'AttendanceType': instance.attendanceType,
      'AttendanceMode': instance.attendanceMode,
      'AttendanceNotes': instance.attendanceNotes,
    };
