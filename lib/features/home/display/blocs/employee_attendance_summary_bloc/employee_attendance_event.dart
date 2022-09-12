part of 'employee_attendance_bloc.dart';

abstract class EmployeeAttendanceEvent extends Equatable {
  const EmployeeAttendanceEvent();

  @override
  List<Object> get props => [];
}

class LoadEmployeeAttendanceSummary extends EmployeeAttendanceEvent {}
