part of 'reprimand_approval_history_bloc.dart';

abstract class ReprimandApprovalHistoryEvent extends Equatable {
  const ReprimandApprovalHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadReprimandApprovalHistoryList extends ReprimandApprovalHistoryEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadReprimandApprovalHistoryList({
    this.status,
    this.type,
    this.dateFilter,
    this.q,
    this.page,
  });
}
