part of 'leave_request_bloc.dart';

abstract class LeaveRequestState extends Equatable {
  const LeaveRequestState();

  @override
  List<Object> get props => [];
}

class LeaveRequestInitial extends LeaveRequestState {}

class LeaveTypesLoadSuccess extends LeaveRequestState {
  final LeaveTypesEntity leaveTypes;

  const LeaveTypesLoadSuccess(this.leaveTypes);

  @override
  List<Object> get props => [leaveTypes];
}

class LeaveTypesLoadFailed extends LeaveRequestState {
  final Map<String, dynamic> errorMsg;

  const LeaveTypesLoadFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class LeaveTypesLoadInProgress extends LeaveRequestState {}

class SubmitLeaveLoading extends LeaveRequestState {}

class SubmitLeaveSuccess extends LeaveRequestState {}

class SubmitLeaveFailure extends LeaveRequestState {}
