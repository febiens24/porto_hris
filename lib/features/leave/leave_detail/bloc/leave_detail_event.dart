part of 'leave_detail_bloc.dart';

abstract class LeaveDetailEvent extends Equatable {
  const LeaveDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadLeaveDetail extends LeaveDetailEvent {
  final int leaveId;

  const LoadLeaveDetail(this.leaveId);

  @override
  List<Object> get props => [leaveId];
}

class ApproveLeaveRequest extends LeaveDetailEvent {
  final int leaveId;

  const ApproveLeaveRequest(this.leaveId);

  @override
  List<Object> get props => [leaveId];
}

class RejectLeaveRequest extends LeaveDetailEvent {
  final int leaveId;
  final String rejectReason;

  const RejectLeaveRequest(this.leaveId, this.rejectReason);

  @override
  List<Object> get props => [leaveId, rejectReason];
}

class PatchLeaveStatus extends LeaveDetailEvent {
  final int leaveId;
  final String state;
  final String? cancelReason;

  const PatchLeaveStatus(this.leaveId, this.state, this.cancelReason);

  @override
  List<Object> get props => [leaveId, cancelReason!];
}
