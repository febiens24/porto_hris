part of 'dispensation_approval_history_bloc.dart';

abstract class DispensationApprovalHistoryEvent extends Equatable {
  const DispensationApprovalHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadDispensationApprovalHistoryList
    extends DispensationApprovalHistoryEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadDispensationApprovalHistoryList({
    this.status,
    this.type,
    this.dateFilter,
    this.q,
    this.page,
  });
}
