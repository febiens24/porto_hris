part of 'dispensation_approval_bloc.dart';

abstract class DispensationApprovalState extends Equatable {
  const DispensationApprovalState();

  @override
  List<Object> get props => [];
}

class DispensationApprovalInitial extends DispensationApprovalState {}

class DispensationApprovalLoading extends DispensationApprovalState {}

class DispensationApprovalLoadSuccess extends DispensationApprovalState {
  final DispensationEntity dispensationApprovalData;

  const DispensationApprovalLoadSuccess(this.dispensationApprovalData);

  @override
  List<Object> get props => [dispensationApprovalData];
}

class DispensationApprovalLoadFailure extends DispensationApprovalState {
  final Map<String, dynamic> errors;

  const DispensationApprovalLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
