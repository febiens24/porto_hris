part of 'business_trip_approval_history_bloc.dart';

abstract class BusinessTripApprovalHistoryEvent extends Equatable {
  const BusinessTripApprovalHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadBusinessTripApprovalHistory extends BusinessTripApprovalHistoryEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadBusinessTripApprovalHistory({
    this.status,
    this.type,
    this.dateFilter,
    this.q,
    this.page,
  });

  // @override
  // List<Object> get props => [
  //       status!,
  //       type!,
  //       dateFilter!,
  //       q!,
  //       page!,
  //     ];
}
