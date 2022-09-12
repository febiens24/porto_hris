part of 'attendance_detail_bloc.dart';

abstract class AttendanceDetailEvent extends Equatable {
  const AttendanceDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadAttendanceDetail extends AttendanceDetailEvent {
  final int leaveId;

  const LoadAttendanceDetail(this.leaveId);

  @override
  List<Object> get props => [leaveId];
}
