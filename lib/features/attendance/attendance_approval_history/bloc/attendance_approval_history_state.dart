part of 'attendance_approval_history_bloc.dart';

abstract class AttendanceApprovalHistoryState extends Equatable {
  const AttendanceApprovalHistoryState();

  @override
  List<Object> get props => [];
}

class AttendanceApprovalHistoryInitial extends AttendanceApprovalHistoryState {}

class AttendanceApprovalHistoryLoading extends AttendanceApprovalHistoryState {}

class AttendanceApprovalHistoryLoadSuccess
    extends AttendanceApprovalHistoryState {
  final AttendanceEntity attendanceApprovals;

  const AttendanceApprovalHistoryLoadSuccess(this.attendanceApprovals);

  @override
  List<Object> get props => [attendanceApprovals];
}

class AttendanceApprovalHistoryLoadFailure
    extends AttendanceApprovalHistoryState {
  final Map<String, dynamic> errors;

  const AttendanceApprovalHistoryLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
