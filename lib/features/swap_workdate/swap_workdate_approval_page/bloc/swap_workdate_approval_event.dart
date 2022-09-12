part of 'swap_workdate_approval_bloc.dart';

abstract class SwapWorkdateApprovalEvent extends Equatable {
  const SwapWorkdateApprovalEvent();

  @override
  List<Object> get props => [];
}

class LoadSwapWorkdateApprovalList extends SwapWorkdateApprovalEvent {}
