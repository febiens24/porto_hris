import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/leave_entity.dart';

part 'leave_model.g.dart';

class LeaveModel extends LeaveEntity {
  const LeaveModel({
    required String status,
    required String message,
    List<LeaveResultEntity>? result,
    List<dynamic>? types,
  }) : super(
          status: status,
          message: message,
          result: result,
          types: types,
        );

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        status: json['status'],
        message: json['message'],
        result: (json['result'] as List<dynamic>?)
            ?.map((e) => LeaveResultModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        types: json['types'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
        'types': types,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class LeaveResultModel extends LeaveResultEntity {
  const LeaveResultModel({
    required int leaveId,
    required String leaveDocumentNumber,
    String? leaveRequesterName,
    String? leaveRequesterProfilePicture,
    String? leaveRequesterRole,
    required String leaveStatus,
    required String leaveRequestDate,
    required String leaveType,
    required String leaveDateFrom,
    required String leaveDateTo,
  }) : super(
          leaveId: leaveId,
          leaveDocumentNumber: leaveDocumentNumber,
          leaveRequesterName: leaveRequesterName,
          leaveRequesterProfilePicture: leaveRequesterProfilePicture,
          leaveRequesterRole: leaveRequesterRole,
          leaveStatus: leaveStatus,
          leaveRequestDate: leaveRequestDate,
          leaveType: leaveType,
          leaveDateFrom: leaveDateFrom,
          leaveDateTo: leaveDateTo,
        );

  factory LeaveResultModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveResultModelToJson(this);
}
