part of 'business_trip_approval_history_bloc.dart';

// abstract class BusinessTripApprovalHistoryState extends Equatable {
//   const BusinessTripApprovalHistoryState();

//   @override
//   List<Object> get props => [];
// }

// class BusinessTripApprovalHistoryInitial
//     extends BusinessTripApprovalHistoryState {}

// class BusinessTripApprovalHistoryLoading
//     extends BusinessTripApprovalHistoryState {}

// class BusinessTripApprovalHistoryLoadSuccess
//     extends BusinessTripApprovalHistoryState {
//   final BusinessTripEntity businessTripApprovalHistory;

//   const BusinessTripApprovalHistoryLoadSuccess(
//       this.businessTripApprovalHistory);

//   @override
//   List<Object> get props => [businessTripApprovalHistory];
// }

// class BusinessTripApprovalHistoryLoadFailure
//     extends BusinessTripApprovalHistoryState {
//   final Map<String, dynamic> errors;

//   const BusinessTripApprovalHistoryLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum BusinessTripApprovalHistoryStatus { initial, success, failure }

class BusinessTripApprovalHistoryState extends Equatable {
  final BusinessTripApprovalHistoryStatus status;
  final List<BusinessTripResultEntity> businessTrips;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const BusinessTripApprovalHistoryState({
    this.status = BusinessTripApprovalHistoryStatus.initial,
    this.businessTrips = const <BusinessTripResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  BusinessTripApprovalHistoryState copyWith({
    BusinessTripApprovalHistoryStatus? status,
    List<BusinessTripResultEntity>? businessTrips,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return BusinessTripApprovalHistoryState(
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
