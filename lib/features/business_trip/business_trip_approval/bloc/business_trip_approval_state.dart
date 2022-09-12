part of 'business_trip_approval_bloc.dart';

abstract class BusinessTripApprovalState extends Equatable {
  const BusinessTripApprovalState();

  @override
  List<Object> get props => [];
}

class BusinessTripApprovalInitial extends BusinessTripApprovalState {}

class BusinessTripApprovalLoading extends BusinessTripApprovalState {}

class BusinessTripApprovalLoadSuccess extends BusinessTripApprovalState {
  final BusinessTripEntity businessTripApproval;

  const BusinessTripApprovalLoadSuccess(this.businessTripApproval);

  @override
  List<Object> get props => [businessTripApproval];
}

class BusinessTripApprovalLoadFailure extends BusinessTripApprovalState {
  final Map<String, dynamic> errors;

  const BusinessTripApprovalLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
