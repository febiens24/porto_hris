part of 'reprimand_approval_history_bloc.dart';

// abstract class ReprimandApprovalHistoryState extends Equatable {
//   const ReprimandApprovalHistoryState();

//   @override
//   List<Object> get props => [];
// }

// class ReprimandApprovalHistoryInitial extends ReprimandApprovalHistoryState {}

// class ReprimandApprovalHistoryLoading extends ReprimandApprovalHistoryState {}

// class ReprimandApprovalHistoryLoadSuccess
//     extends ReprimandApprovalHistoryState {
//   final ReprimandEntity reprimandApprovalHistory;

//   const ReprimandApprovalHistoryLoadSuccess(this.reprimandApprovalHistory);

//   @override
//   List<Object> get props => [reprimandApprovalHistory];
// }

// class ReprimandApprovalHistoryLoadFailure
//     extends ReprimandApprovalHistoryState {
//   final Map<String, dynamic> errors;

//   const ReprimandApprovalHistoryLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum ReprimandApprovalHistoryListStatus { initial, success, failure }

class ReprimandApprovalHistoryState extends Equatable {
  final ReprimandApprovalHistoryListStatus status;
  final List<ReprimandResultEntity> reprimands;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const ReprimandApprovalHistoryState({
    this.status = ReprimandApprovalHistoryListStatus.initial,
    this.reprimands = const <ReprimandResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  ReprimandApprovalHistoryState copyWith({
    ReprimandApprovalHistoryListStatus? status,
    List<ReprimandResultEntity>? reprimands,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return ReprimandApprovalHistoryState(
      status: status ?? this.status,
      reprimands: reprimands ?? this.reprimands,
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
        reprimands,
        hasReachedMax,
        currentStateFilter,
        currentTypeFilter,
        currentDateFilter,
        searchQuery,
        listTypes,
        page,
      ];
}
