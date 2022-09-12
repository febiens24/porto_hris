part of 'swap_workdate_approval_bloc.dart';

abstract class SwapWorkdateApprovalState extends Equatable {
  const SwapWorkdateApprovalState();

  @override
  List<Object> get props => [];
}

class SwapWorkdateApprovalInitial extends SwapWorkdateApprovalState {}

class SwapWorkdateApprovalLoading extends SwapWorkdateApprovalState {}

class SwapWorkdateApprovalLoadSuccess extends SwapWorkdateApprovalState {
  final SwapWorkdateEntity swapWorkdateApprovals;

  const SwapWorkdateApprovalLoadSuccess(this.swapWorkdateApprovals);

  @override
  List<Object> get props => [swapWorkdateApprovals];
}

class SwapWorkdateApprovalLoadFailure extends SwapWorkdateApprovalState {
  final Map<String, dynamic> errors;

  const SwapWorkdateApprovalLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
