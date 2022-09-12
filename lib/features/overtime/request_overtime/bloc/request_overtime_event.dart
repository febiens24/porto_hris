part of 'request_overtime_bloc.dart';

abstract class RequestOvertimeEvent extends Equatable {
  const RequestOvertimeEvent();

  @override
  List<Object> get props => [];
}

class SubmitOvertime extends RequestOvertimeEvent {}
