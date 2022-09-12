part of 'attendance_list_bloc.dart';

abstract class AttendanceListState extends Equatable {
  const AttendanceListState();

  @override
  List<Object> get props => [];
}

class AttendanceListInitial extends AttendanceListState {}

class AttendanceListLoadSuccess extends AttendanceListState {
  final AttendanceEntity attendanceList;

  const AttendanceListLoadSuccess(this.attendanceList);

  @override
  List<Object> get props => [attendanceList];
}

class AttendanceListLoadFailed extends AttendanceListState {
  final Map<String, dynamic> errorMsg;

  const AttendanceListLoadFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class AttendanceListLoadInProgress extends AttendanceListState {}
