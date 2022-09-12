part of 'swap_workdate_list_bloc.dart';

// abstract class SwapWorkdateListState extends Equatable {
//   const SwapWorkdateListState();

//   @override
//   List<Object> get props => [];
// }

// class SwapWorkdateListInitial extends SwapWorkdateListState {}

// class SwapWorkdateListLoading extends SwapWorkdateListState {}

// class SwapWorkdateListLoadSuccess extends SwapWorkdateListState {
//   final SwapWorkdateEntity reprimandList;

//   const SwapWorkdateListLoadSuccess(this.reprimandList);

//   @override
//   List<Object> get props => [reprimandList];
// }

// class SwapWorkdateListLoadFailure extends SwapWorkdateListState {
//   final Map<String, dynamic> errors;

//   const SwapWorkdateListLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }
enum SwapWordateListState { initial, success, failure }

class SwapWorkdateListState extends Equatable {
  final SwapWordateListState status;
  final List<SwapWorkdateResultEntity> swapWorkdates;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final int page;

  const SwapWorkdateListState({
    this.status = SwapWordateListState.initial,
    this.swapWorkdates = const <SwapWorkdateResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.page = 1,
  });

  SwapWorkdateListState copyWith({
    SwapWordateListState? status,
    List<SwapWorkdateResultEntity>? swapWorkdates,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    int? page,
  }) {
    return SwapWorkdateListState(
      status: status ?? this.status,
      swapWorkdates: swapWorkdates ?? this.swapWorkdates,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentStateFilter: currentStateFilter ?? this.currentStateFilter,
      currentTypeFilter: currentTypeFilter ?? this.currentTypeFilter,
      currentDateFilter: currentDateFilter ?? this.currentDateFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        status,
        swapWorkdates,
        hasReachedMax,
        currentStateFilter,
        currentTypeFilter,
        currentDateFilter,
        searchQuery,
        page,
      ];
}
