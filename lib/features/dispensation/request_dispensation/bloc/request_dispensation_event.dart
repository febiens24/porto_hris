part of 'request_dispensation_bloc.dart';

abstract class RequestDispensationEvent extends Equatable {
  const RequestDispensationEvent();

  @override
  List<Object> get props => [];
}

class SubmitDispensation extends RequestDispensationEvent {}
