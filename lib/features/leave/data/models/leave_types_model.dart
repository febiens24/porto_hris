import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/leave_types_entity.dart';

part 'leave_types_model.g.dart';

class LeaveTypesModel extends LeaveTypesEntity {
  const LeaveTypesModel({
    required String status,
    required String message,
    required List<LeaveTypeResultEntity> result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory LeaveTypesModel.fromJson(Map<String, dynamic> json) =>
      LeaveTypesModel(
        status: json['status'],
        message: json['message'],
        result: (json['result'] as List<dynamic>)
            .map((e) =>
                LeaveTypesResultModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class LeaveTypesResultModel extends LeaveTypeResultEntity {
  const LeaveTypesResultModel({
    required String leaveType,
    required double leaveBalance,
    required bool isHalfdayAllowed,
  }) : super(
          leaveType: leaveType,
          leaveBalance: leaveBalance,
          isHalfdayAllowed: isHalfdayAllowed,
        );

  factory LeaveTypesResultModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypesResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypesResultModelToJson(this);
}
