import 'package:equatable/equatable.dart';

class EmployeePenaltySummaryEntity extends Equatable {
  final String status;
  final String message;
  final EmployeePenaltySummaryResultEntity result;

  const EmployeePenaltySummaryEntity({
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

class EmployeePenaltySummaryResultEntity extends Equatable {
  final String summaryPeriod;
  final int absentCount;
  final int forgotClockInCount;
  final int forgotClockOutCount;
  final int lateCount;
  final int goEarlyCount;

  const EmployeePenaltySummaryResultEntity({
    required this.summaryPeriod,
    required this.absentCount,
    required this.forgotClockInCount,
    required this.forgotClockOutCount,
    required this.lateCount,
    required this.goEarlyCount,
  });

  @override
  List<Object?> get props => [
        summaryPeriod,
        absentCount,
        forgotClockInCount,
        forgotClockOutCount,
        lateCount,
        goEarlyCount,
      ];
}
