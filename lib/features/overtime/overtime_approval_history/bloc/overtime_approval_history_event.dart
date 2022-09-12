part of 'overtime_approval_history_bloc.dart';

abstract class OvertimeApprovalHistoryEvent extends Equatable {
  const OvertimeApprovalHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadOvertimeApprovalHistoryList extends OvertimeApprovalHistoryEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadOvertimeApprovalHistoryList({
    this.status,
    this.type,
    this.dateFilter,
    this.q,
    this.page,
  });
}
