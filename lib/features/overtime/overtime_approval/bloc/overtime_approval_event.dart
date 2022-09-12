part of 'overtime_approval_bloc.dart';

abstract class OvertimeApprovalEvent extends Equatable {
  const OvertimeApprovalEvent();

  @override
  List<Object> get props => [];
}

class LoadOvertimeApprovalList extends OvertimeApprovalEvent {}
