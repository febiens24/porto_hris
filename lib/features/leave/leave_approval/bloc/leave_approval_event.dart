part of 'leave_approval_bloc.dart';

abstract class LeaveApprovalEvent extends Equatable {
  const LeaveApprovalEvent();

  @override
  List<Object> get props => [];
}

class LoadLeaveApprovalList extends LeaveApprovalEvent {}

class ApproveLeaveRequest extends LeaveApprovalEvent {
  final int leaveId;

  const ApproveLeaveRequest(this.leaveId);

  @override
  List<Object> get props => [leaveId];
}

class RejectLeaveRequest extends LeaveApprovalEvent {
  final int leaveId;
  final String rejectReason;

  const RejectLeaveRequest(this.leaveId, this.rejectReason);

  @override
  List<Object> get props => [leaveId, rejectReason];
}
