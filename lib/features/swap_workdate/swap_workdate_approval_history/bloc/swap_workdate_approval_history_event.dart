part of 'swap_workdate_approval_history_bloc.dart';

abstract class SwapWorkdateApprovalHistoryEvent extends Equatable {
  const SwapWorkdateApprovalHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadSwapWorkdateApprovalHistoryList
    extends SwapWorkdateApprovalHistoryEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadSwapWorkdateApprovalHistoryList({
    this.status,
    this.type,
    this.dateFilter,
    this.q,
    this.page,
  });
}
