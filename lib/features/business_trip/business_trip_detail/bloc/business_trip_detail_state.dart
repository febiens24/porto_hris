part of 'business_trip_detail_bloc.dart';

abstract class BusinessTripDetailState extends Equatable {
  const BusinessTripDetailState();

  @override
  List<Object> get props => [];
}

class BusinessTripDetailInitial extends BusinessTripDetailState {}

class BusinessTripDetailLoadSuccess extends BusinessTripDetailState {
  final BusinessTripDetailEntity businessTripDetail;

  const BusinessTripDetailLoadSuccess(this.businessTripDetail);

  @override
  List<Object> get props => [businessTripDetail];
}

class BusinessTripDetailLoadFailed extends BusinessTripDetailState {
  final Map<String, dynamic> errorMsg;

  const BusinessTripDetailLoadFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class BusinessTripDetailLoadInProgress extends BusinessTripDetailState {}
