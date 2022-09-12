part of 'request_dispensation_bloc.dart';

abstract class RequestDispensationState extends Equatable {
  const RequestDispensationState();

  @override
  List<Object> get props => [];
}

class RequestDispensationInitial extends RequestDispensationState {}

class SubmitDispensationLoading extends RequestDispensationState {}

class SubmitDispensationSuccess extends RequestDispensationState {}

class SubmitDispensationFailure extends RequestDispensationState {}
