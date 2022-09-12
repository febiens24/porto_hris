part of 'leave_approval_bloc.dart';

abstract class LeaveApprovalState extends Equatable {
  const LeaveApprovalState();

  @override
  List<Object> get props => [];
}

class LeaveApprovalInitial extends LeaveApprovalState {}

class LeaveApprovalLoading extends LeaveApprovalState {}

class LeaveApprovalLoadSuccess extends LeaveApprovalState {
  final LeaveEntity leaveApproval;

  const LeaveApprovalLoadSuccess(this.leaveApproval);

  @override
  List<Object> get props => [leaveApproval];
}

class LeaveApprovalLoadFailure extends LeaveApprovalState {
  final Map<String, dynamic> errors;

  const LeaveApprovalLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
