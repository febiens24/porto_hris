import 'package:equatable/equatable.dart';

class EmployeeAttendanceSummaryEntity extends Equatable {
  final String status;
  final String message;
  final EmployeeAttendanceSummaryResultEntity result;

  const EmployeeAttendanceSummaryEntity({
    required this.status,
    required this.message,
    required this.result,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        result,
      ];
}

class EmployeeAttendanceSummaryResultEntity extends Equatable {
  final String summaryPeriod;
  final int attendanceCount;
  final int sickCount;
  final int leaveCount;
  final int dispensationCount;

  const EmployeeAttendanceSummaryResultEntity({
    required this.summaryPeriod,
    required this.attendanceCount,
    required this.sickCount,
    required this.leaveCount,
    required this.dispensationCount,
  });

  @override
  List<Object?> get props => [
        summaryPeriod,
        attendanceCount,
        sickCount,
        leaveCount,
        dispensationCount,
      ];
}
