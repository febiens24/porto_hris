part of 'request_business_trip_bloc.dart';

abstract class RequestBusinessTripEvent extends Equatable {
  const RequestBusinessTripEvent();

  @override
  List<Object> get props => [];
}

class SubmitBusinessTrip extends RequestBusinessTripEvent {}
