part of 'overtime_approval_bloc.dart';

abstract class OvertimeApprovalState extends Equatable {
  const OvertimeApprovalState();

  @override
  List<Object> get props => [];
}

class OvertimeApprovalInitial extends OvertimeApprovalState {}

class OvertimeApprovalLoading extends OvertimeApprovalState {}

class OvertimeApprovalLoadSuccess extends OvertimeApprovalState {
  final OvertimeEntity overtimeApproval;

  const OvertimeApprovalLoadSuccess(this.overtimeApproval);

  @override
  List<Object> get props => [overtimeApproval];
}

class OvertimeApprovalLoadFailure extends OvertimeApprovalState {
  final Map<String, dynamic> errors;

  const OvertimeApprovalLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
