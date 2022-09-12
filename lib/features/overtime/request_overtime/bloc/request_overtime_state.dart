part of 'request_overtime_bloc.dart';

abstract class RequestOvertimeState extends Equatable {
  const RequestOvertimeState();

  @override
  List<Object> get props => [];
}

class RequestOvertimeInitial extends RequestOvertimeState {}

class SubmitOvertimeLoading extends RequestOvertimeState {}

class SubmitOvertimeSuccess extends RequestOvertimeState {}

class SubmitOvertimeFailure extends RequestOvertimeState {}
