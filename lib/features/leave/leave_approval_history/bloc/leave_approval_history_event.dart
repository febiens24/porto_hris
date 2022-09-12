part of 'leave_approval_history_bloc.dart';

abstract class LeaveApprovalHistoryEvent extends Equatable {
  const LeaveApprovalHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadLeaveApprovalHistoryList extends LeaveApprovalHistoryEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadLeaveApprovalHistoryList({
    this.status = 'all',
    this.type = 'all',
    this.dateFilter = 'all',
    this.q = '',
    this.page = 1,
  });

  @override
  List<Object> get props => [
        status!,
        type!,
        dateFilter!,
        q!,
        page!,
      ];
}
