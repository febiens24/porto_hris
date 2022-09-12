part of 'attendance_approval_bloc.dart';

abstract class AttendanceApprovalState extends Equatable {
  const AttendanceApprovalState();

  @override
  List<Object> get props => [];
}

class AttendanceApprovalInitial extends AttendanceApprovalState {}

class AttendanceApprovalLoading extends AttendanceApprovalState {}

class AttendanceApprovalLoadSuccess extends AttendanceApprovalState {
  final AttendanceEntity attendanceApprovals;

  const AttendanceApprovalLoadSuccess(this.attendanceApprovals);

  @override
  List<Object> get props => [attendanceApprovals];
}

class AttendanceApprovalLoadFailure extends AttendanceApprovalState {
  final Map<String, dynamic> errors;

  const AttendanceApprovalLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
