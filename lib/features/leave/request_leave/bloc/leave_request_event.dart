part of 'leave_request_bloc.dart';

abstract class LeaveRequestEvent extends Equatable {
  const LeaveRequestEvent();

  @override
  List<Object> get props => [];
}

class LoadLeaveTypes extends LeaveRequestEvent {}

class SubmitRequest extends LeaveRequestEvent {}
