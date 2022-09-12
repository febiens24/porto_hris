part of 'business_trip_bloc.dart';

// abstract class BusinessTripState extends Equatable {
//   const BusinessTripState();

//   @override
//   List<Object> get props => [];
// }

// class BusinessTripInitial extends BusinessTripState {}

// class BusinessTripLoading extends BusinessTripState {}

// class BusinessTripLoadSuccess extends BusinessTripState {
//   final BusinessTripEntity businessTrips;

//   const BusinessTripLoadSuccess(this.businessTrips);

//   @override
//   List<Object> get props => [businessTrips];
// }

// class BusinessTripLoadFailure extends BusinessTripState {
//   final Map<String, dynamic> errors;

//   const BusinessTripLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum BusinessTripStatus { initial, success, failure }

class BusinessTripState extends Equatable {
  final BusinessTripStatus status;
  final List<BusinessTripResultEntity> businessTrips;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const BusinessTripState({
    this.status = BusinessTripStatus.initial,
    this.businessTrips = const <BusinessTripResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  BusinessTripState copyWith({
    BusinessTripStatus? status,
    List<BusinessTripResultEntity>? businessTrips,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return BusinessTripState(
      status: status ?? this.status,
      businessTrips: businessTrips ?? this.businessTrips,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentStateFilter: currentStateFilter ?? this.currentStateFilter,
      currentTypeFilter: currentTypeFilter ?? this.currentTypeFilter,
      currentDateFilter: currentDateFilter ?? this.currentDateFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      listTypes: listTypes ?? this.listTypes,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        status,
        businessTrips,
        hasReachedMax,
        currentStateFilter,
        currentTypeFilter,
        currentDateFilter,
        searchQuery,
        listTypes,
        page,
      ];
}
