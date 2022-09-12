part of 'attendance_detail_bloc.dart';

abstract class AttendanceDetailState extends Equatable {
  const AttendanceDetailState();

  @override
  List<Object> get props => [];
}

class AttendanceDetailInitial extends AttendanceDetailState {}

class AttendanceDetailLoadSuccess extends AttendanceDetailState {
  final AttendanceDetailEntity attendanceDetail;

  const AttendanceDetailLoadSuccess(this.attendanceDetail);

  @override
  List<Object> get props => [attendanceDetail];
}

class AttendanceDetailLoadFailed extends AttendanceDetailState {
  final Map<String, dynamic> errorMsg;

  const AttendanceDetailLoadFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class AttendanceDetailLoadInProgress extends AttendanceDetailState {}
