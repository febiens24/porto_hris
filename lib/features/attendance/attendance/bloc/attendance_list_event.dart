part of 'attendance_list_bloc.dart';

abstract class AttendanceListEvent extends Equatable {
  const AttendanceListEvent();

  @override
  List<Object> get props => [];
}

class LoadAttendanceList extends AttendanceListEvent {
  const LoadAttendanceList();

  @override
  List<Object> get props => [];
}
