import 'package:equatable/equatable.dart';

class ApprovalsEntity extends Equatable {
  final String status;
  final String message;
  final ApprovalsResultEntity result;

  const ApprovalsEntity({
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

class ApprovalsResultEntity extends Equatable {
  final int attendanceCount;
  final int leaveCount;
  final int businessTripCount;
  final int overtimeCount;
  final int dispensationCount;
  final int swapWorkdateCount;
  final int reprimandCount;

  const ApprovalsResultEntity({
    required this.attendanceCount,
    required this.leaveCount,
    required this.businessTripCount,
    required this.overtimeCount,
    required this.dispensationCount,
    required this.swapWorkdateCount,
    required this.reprimandCount,
  });

  @override
  List<Object?> get props => [
        attendanceCount,
        leaveCount,
        businessTripCount,
        overtimeCount,
        dispensationCount,
        swapWorkdateCount,
        reprimandCount,
      ];
}
