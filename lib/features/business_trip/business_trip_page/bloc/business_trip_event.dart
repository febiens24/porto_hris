part of 'business_trip_bloc.dart';

abstract class BusinessTripEvent extends Equatable {
  const BusinessTripEvent();

  @override
  List<Object> get props => [];
}

class LoadBusinessTripList extends BusinessTripEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadBusinessTripList({
    this.status = 'all',
    this.type = 'all',
    this.dateFilter = 'all',
    this.q = '',
    this.page = 1,
  });

  @override
  List<Object> get props => [
        status!,
        type!,
        dateFilter!,
        q!,
        page!,
      ];
}
