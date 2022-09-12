part of 'employee_attendance_bloc.dart';

abstract class EmployeeAttendanceState extends Equatable {
  const EmployeeAttendanceState();

  @override
  List<Object> get props => [];
}

class EmployeeAttendanceInitial extends EmployeeAttendanceState {}

class EmployeeAttendanceLoading extends EmployeeAttendanceState {}

class EmployeeAttendanceLoadSuccess extends EmployeeAttendanceState {
  final EmployeeAttendanceSummaryEntity attendanceSummary;

  const EmployeeAttendanceLoadSuccess({
    required this.attendanceSummary,
  });

  @override
  List<Object> get props => [attendanceSummary];
}

class EmployeeAttendanceLoadFailure extends EmployeeAttendanceState {
  final Map<String, dynamic> errorMsg;

  const EmployeeAttendanceLoadFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
