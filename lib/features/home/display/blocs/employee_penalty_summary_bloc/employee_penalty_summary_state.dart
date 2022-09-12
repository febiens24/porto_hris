part of 'employee_penalty_summary_bloc.dart';

abstract class EmployeePenaltySummaryState extends Equatable {
  const EmployeePenaltySummaryState();

  @override
  List<Object> get props => [];
}

class EmployeePenaltySummaryInitial extends EmployeePenaltySummaryState {}

class EmployeePenaltySummaryLoading extends EmployeePenaltySummaryState {}

class EmployeePenaltySummaryLoadSuccess extends EmployeePenaltySummaryState {
  final EmployeePenaltySummaryEntity penaltySummary;

  const EmployeePenaltySummaryLoadSuccess({
    required this.penaltySummary,
  });

  @override
  List<Object> get props => [penaltySummary];
}

class EmployeePenaltySummaryLoadFailure extends EmployeePenaltySummaryState {
  final Map<String, dynamic> errorMsg;

  const EmployeePenaltySummaryLoadFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
