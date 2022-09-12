part of 'leave_approval_history_bloc.dart';

// abstract class LeaveApprovalHistoryState extends Equatable {
//   const LeaveApprovalHistoryState();

//   @override
//   List<Object> get props => [];
// }

// class LeaveApprovalHistoryInitial extends LeaveApprovalHistoryState {}

// class LeaveApprovalHistoryLoading extends LeaveApprovalHistoryState {}

// class LeaveApprovalHistoryLoadSuccess extends LeaveApprovalHistoryState {
//   final LeaveEntity dispensationApprovalHistory;

//   const LeaveApprovalHistoryLoadSuccess(this.dispensationApprovalHistory);

//   @override
//   List<Object> get props => [dispensationApprovalHistory];
// }

// class LeaveApprovalHistoryLoadFailure extends LeaveApprovalHistoryState {
//   final Map<String, dynamic> errors;

//   const LeaveApprovalHistoryLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum LeaveApprovalHistoryStatus { initial, success, failure }

class LeaveApprovalHistoryState extends Equatable {
  final LeaveApprovalHistoryStatus status;
  final List<LeaveResultEntity> leaves;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const LeaveApprovalHistoryState({
    this.status = LeaveApprovalHistoryStatus.initial,
    this.leaves = const <LeaveResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  LeaveApprovalHistoryState copyWith({
    LeaveApprovalHistoryStatus? status,
    List<LeaveResultEntity>? leaves,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return LeaveApprovalHistoryState(
      status: status ?? this.status,
      leaves: leaves ?? this.leaves,
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
        leaves,
        hasReachedMax,
        currentStateFilter,
        currentTypeFilter,
        currentDateFilter,
        searchQuery,
        listTypes,
        page,
      ];
}
