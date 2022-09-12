part of 'attendance_approval_bloc.dart';

abstract class AttendanceApprovalEvent extends Equatable {
  const AttendanceApprovalEvent();

  @override
  List<Object> get props => [];
}

class LoadAttendanceApprovalList extends AttendanceApprovalEvent {}
