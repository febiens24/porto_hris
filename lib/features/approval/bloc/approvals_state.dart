part of 'approvals_bloc.dart';

abstract class ApprovalsState extends Equatable {
  const ApprovalsState();

  @override
  List<Object> get props => [];
}

class ApprovalsInitial extends ApprovalsState {}

class ApprovalsLoadSuccess extends ApprovalsState {
  final ApprovalsEntity approvalsCount;

  const ApprovalsLoadSuccess(this.approvalsCount);

  @override
  List<Object> get props => [approvalsCount];
}

class ApprovalsLoadFailed extends ApprovalsState {
  final Map<String, dynamic> errorMsg;

  const ApprovalsLoadFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class ApprovalsLoadInProgress extends ApprovalsState {}
