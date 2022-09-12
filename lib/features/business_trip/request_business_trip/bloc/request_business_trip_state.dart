part of 'request_business_trip_bloc.dart';

abstract class RequestBusinessTripState extends Equatable {
  const RequestBusinessTripState();

  @override
  List<Object> get props => [];
}

class RequestBusinessTripInitial extends RequestBusinessTripState {}

class SubmitBusinessTripLoading extends RequestBusinessTripState {}

class SubmitBusinessTripSuccess extends RequestBusinessTripState {}

class SubmitBusinessTripFailure extends RequestBusinessTripState {}
