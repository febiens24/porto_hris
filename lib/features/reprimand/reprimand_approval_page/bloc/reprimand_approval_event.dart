part of 'reprimand_approval_bloc.dart';

abstract class ReprimandApprovalEvent extends Equatable {
  const ReprimandApprovalEvent();

  @override
  List<Object> get props => [];
}

class LoadReprimandApprovalList extends ReprimandApprovalEvent {}
