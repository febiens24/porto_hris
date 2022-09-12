import '../../domain/entities/employee_attendance_summary_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_attendance_summary_model.g.dart';

class EmployeeAttendanceSummaryModel extends EmployeeAttendanceSummaryEntity {
  const EmployeeAttendanceSummaryModel({
    required String status,
    required String message,
    required EmployeeAttendanceSummaryResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory EmployeeAttendanceSummaryModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAttendanceSummaryModel(
        status: json['status'],
        message: json['message'],
        result: EmployeeAttendanceSummaryResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class EmployeeAttendanceSummaryResultModel
    extends EmployeeAttendanceSummaryResultEntity {
  const EmployeeAttendanceSummaryResultModel({
    required String summaryPeriod,
    required int attendanceCount,
    required int sickCount,
    required int leaveCount,
    required int dispensationCount,
  }) : super(
          summaryPeriod: summaryPeriod,
          attendanceCount: attendanceCount,
          sickCount: sickCount,
          leaveCount: leaveCount,
          dispensationCount: dispensationCount,
        );

  factory EmployeeAttendanceSummaryResultModel.fromJson(
          Map<String, dynamic> json) =>
      _$EmployeeAttendanceSummaryResultModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EmployeeAttendanceSummaryResultModelToJson(this);
}
