part of 'swap_workdate_approval_history_bloc.dart';

// abstract class SwapWorkdateApprovalHistoryState extends Equatable {
//   const SwapWorkdateApprovalHistoryState();

//   @override
//   List<Object> get props => [];
// }

// class SwapWorkdateApprovalHistoryInitial
//     extends SwapWorkdateApprovalHistoryState {}

// class SwapWorkdateApprovalHistoryLoading
//     extends SwapWorkdateApprovalHistoryState {}

// class SwapWorkdateApprovalHistoryLoadSuccess
//     extends SwapWorkdateApprovalHistoryState {
//   final SwapWorkdateEntity swapWorkdateApprovalHistory;

//   const SwapWorkdateApprovalHistoryLoadSuccess(
//       this.swapWorkdateApprovalHistory);

//   @override
//   List<Object> get props => [swapWorkdateApprovalHistory];
// }

// class SwapWorkdateApprovalHistoryLoadFailure
//     extends SwapWorkdateApprovalHistoryState {
//   final Map<String, dynamic> errors;

//   const SwapWorkdateApprovalHistoryLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum SwapWorkdateHistoryListStatus { initial, success, failure }

class SwapWorkdateApprovalHistoryState extends Equatable {
  final SwapWorkdateHistoryListStatus status;
  final List<SwapWorkdateResultEntity> swapworkdates;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const SwapWorkdateApprovalHistoryState({
    this.status = SwapWorkdateHistoryListStatus.initial,
    this.swapworkdates = const <SwapWorkdateResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  SwapWorkdateApprovalHistoryState copyWith({
    SwapWorkdateHistoryListStatus? status,
    List<SwapWorkdateResultEntity>? swapworkdates,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return SwapWorkdateApprovalHistoryState(
      status: status ?? this.status,
      swapworkdates: swapworkdates ?? this.swapworkdates,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentStateFilter: currentStateFilter ?? this.currentStateFilter,
      currentDateFilter: currentDateFilter ?? this.currentDateFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      listTypes: listTypes ?? this.listTypes,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        status,
        swapworkdates,
        hasReachedMax,
        currentStateFilter,
        currentDateFilter,
        searchQuery,
        listTypes,
        page,
      ];
}
