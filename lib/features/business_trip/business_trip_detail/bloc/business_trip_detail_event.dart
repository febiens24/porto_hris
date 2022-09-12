part of 'business_trip_detail_bloc.dart';

abstract class BusinessTripDetailEvent extends Equatable {
  const BusinessTripDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadBusinessTripDetail extends BusinessTripDetailEvent {
  final int businessTripId;

  const LoadBusinessTripDetail(this.businessTripId);

  @override
  List<Object> get props => [businessTripId];
}
