import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/approvals_entity.dart';

part 'approvals_model.g.dart';

class ApprovalsModel extends ApprovalsEntity {
  const ApprovalsModel({
    required String status,
    required String message,
    required ApprovalsResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory ApprovalsModel.fromJson(Map<String, dynamic> json) => ApprovalsModel(
        status: json['status'],
        message: json['message'],
        result: ApprovalsResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ApprovalsResultModel extends ApprovalsResultEntity {
  const ApprovalsResultModel({
    required int attendanceCount,
    required int leaveCount,
    required int businessTripCount,
    required int overtimeCount,
    required int dispensationCount,
    required int swapWorkdateCount,
    required int reprimandCount,
  }) : super(
          attendanceCount: attendanceCount,
          leaveCount: leaveCount,
          businessTripCount: businessTripCount,
          overtimeCount: overtimeCount,
          dispensationCount: dispensationCount,
          swapWorkdateCount: swapWorkdateCount,
          reprimandCount: reprimandCount,
        );

  factory ApprovalsResultModel.fromJson(Map<String, dynamic> json) =>
      _$ApprovalsResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalsResultModelToJson(this);
}
