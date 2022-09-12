part of 'employee_penalty_summary_bloc.dart';

abstract class EmployeePenaltySummaryEvent extends Equatable {
  const EmployeePenaltySummaryEvent();

  @override
  List<Object> get props => [];
}

class LoadEmployeePenaltySummary extends EmployeePenaltySummaryEvent {}
