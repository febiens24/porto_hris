// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveResultModel _$LeaveResultModelFromJson(Map<String, dynamic> json) =>
    LeaveResultModel(
      leaveId: json['LeaveId'] as int,
      leaveDocumentNumber: json['LeaveDocumentNumber'] as String,
      leaveRequesterName: json['LeaveRequesterName'] as String?,
      leaveRequesterProfilePicture:
          json['LeaveRequesterProfilePicture'] as String?,
      leaveRequesterRole: json['LeaveRequesterRole'] as String?,
      leaveStatus: json['LeaveStatus'] as String,
      leaveRequestDate: json['LeaveRequestDate'] as String,
      leaveType: json['LeaveType'] as String,
      leaveDateFrom: json['LeaveDateFrom'] as String,
      leaveDateTo: json['LeaveDateTo'] as String,
    );

Map<String, dynamic> _$LeaveResultModelToJson(LeaveResultModel instance) =>
    <String, dynamic>{
      'LeaveId': instance.leaveId,
      'LeaveDocumentNumber': instance.leaveDocumentNumber,
      'LeaveRequesterName': instance.leaveRequesterName,
      'LeaveRequesterProfilePicture': instance.leaveRequesterProfilePicture,
      'LeaveRequesterRole': instance.leaveRequesterRole,
      'LeaveStatus': instance.leaveStatus,
      'LeaveRequestDate': instance.leaveRequestDate,
      'LeaveType': instance.leaveType,
      'LeaveDateFrom': instance.leaveDateFrom,
      'LeaveDateTo': instance.leaveDateTo,
    };
