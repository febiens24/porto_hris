part of 'attendance_approval_history_bloc.dart';

abstract class AttendanceApprovalHistoryEvent extends Equatable {
  const AttendanceApprovalHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadAttendanceApprovalHistory extends AttendanceApprovalHistoryEvent {}
