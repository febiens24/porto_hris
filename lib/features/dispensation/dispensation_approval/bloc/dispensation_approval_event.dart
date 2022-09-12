part of 'dispensation_approval_bloc.dart';

abstract class DispensationApprovalEvent extends Equatable {
  const DispensationApprovalEvent();

  @override
  List<Object> get props => [];
}

class LoadDispensationApprovalList extends DispensationApprovalEvent {}
