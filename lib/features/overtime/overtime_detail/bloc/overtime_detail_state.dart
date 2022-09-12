part of 'overtime_detail_bloc.dart';

abstract class OvertimeDetailState extends Equatable {
  const OvertimeDetailState();

  @override
  List<Object> get props => [];
}

class OvertimeDetailInitial extends OvertimeDetailState {}

class OvertimeDetailLoading extends OvertimeDetailState {}

class OvertimeListLoadSuccess extends OvertimeDetailState {
  final OvertimeDetailEntity overtimeDetail;

  const OvertimeListLoadSuccess(this.overtimeDetail);

  @override
  List<Object> get props => [overtimeDetail];
}

class OvertimeDetailLoadFailure extends OvertimeDetailState {
  final Map<String, dynamic> errors;

  const OvertimeDetailLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
