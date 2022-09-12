import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/employee_penalty_summary_entity.dart';

part 'employee_penalty_summary_model.g.dart';

class EmployeePenaltySummaryModel extends EmployeePenaltySummaryEntity {
  const EmployeePenaltySummaryModel({
    required String status,
    required String message,
    required EmployeePenaltySummaryResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory EmployeePenaltySummaryModel.fromJson(Map<String, dynamic> json) =>
      EmployeePenaltySummaryModel(
        status: json['status'],
        message: json['message'],
        result: EmployeePenaltySummaryResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class EmployeePenaltySummaryResultModel
    extends EmployeePenaltySummaryResultEntity {
  const EmployeePenaltySummaryResultModel({
    required String summaryPeriod,
    required int absentCount,
    required int forgotClockInCount,
    required int forgotClockOutCount,
    required int lateCount,
    required int goEarlyCount,
  }) : super(
          summaryPeriod: summaryPeriod,
          absentCount: absentCount,
          forgotClockInCount: forgotClockInCount,
          forgotClockOutCount: forgotClockOutCount,
          lateCount: lateCount,
          goEarlyCount: goEarlyCount,
        );
  factory EmployeePenaltySummaryResultModel.fromJson(
          Map<String, dynamic> json) =>
      _$EmployeePenaltySummaryResultModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EmployeePenaltySummaryResultModelToJson(this);
}
