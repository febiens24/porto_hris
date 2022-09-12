part of 'reprimand_approval_bloc.dart';

abstract class ReprimandApprovalState extends Equatable {
  const ReprimandApprovalState();

  @override
  List<Object> get props => [];
}

class ReprimandApprovalInitial extends ReprimandApprovalState {}

class ReprimandApprovalLoading extends ReprimandApprovalState {}

class ReprimandApprovalLoadSuccess extends ReprimandApprovalState {
  final ReprimandEntity reprimandApprovals;

  const ReprimandApprovalLoadSuccess(this.reprimandApprovals);

  @override
  List<Object> get props => [reprimandApprovals];
}

class ReprimandApprovalLoadFailure extends ReprimandApprovalState {
  final Map<String, dynamic> errors;

  const ReprimandApprovalLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
