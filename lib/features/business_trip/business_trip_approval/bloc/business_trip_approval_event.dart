part of 'business_trip_approval_bloc.dart';

abstract class BusinessTripApprovalEvent extends Equatable {
  const BusinessTripApprovalEvent();

  @override
  List<Object> get props => [];
}

class LoadBusinessTripApprovalList extends BusinessTripApprovalEvent {}
