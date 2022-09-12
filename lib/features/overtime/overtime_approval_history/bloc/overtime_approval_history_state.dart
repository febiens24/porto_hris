part of 'overtime_approval_history_bloc.dart';

// abstract class OvertimeApprovalHistoryState extends Equatable {
//   const OvertimeApprovalHistoryState();

//   @override
//   List<Object> get props => [];
// }

// class OvertimeApprovalHistoryInitial extends OvertimeApprovalHistoryState {}

// class OvertimeApprovalHistoryLoading extends OvertimeApprovalHistoryState {}

// class OvertimeApprovalHistoryLoadSuccess extends OvertimeApprovalHistoryState {
//   final OvertimeEntity overtimeApprovalHistory;

//   const OvertimeApprovalHistoryLoadSuccess(this.overtimeApprovalHistory);

//   @override
//   List<Object> get props => [overtimeApprovalHistory];
// }

// class OvertimeApprovalHistoryLoadFailure extends OvertimeApprovalHistoryState {
//   final Map<String, dynamic> errors;

//   const OvertimeApprovalHistoryLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum OvertimeApprovalHistoryListStatus { initial, success, failure }

class OvertimeApprovalHistoryState extends Equatable {
  final OvertimeApprovalHistoryListStatus status;
  final List<OvertimeResultEntity> overtimes;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const OvertimeApprovalHistoryState({
    this.status = OvertimeApprovalHistoryListStatus.initial,
    this.overtimes = const <OvertimeResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  OvertimeApprovalHistoryState copyWith({
    OvertimeApprovalHistoryListStatus? status,
    List<OvertimeResultEntity>? overtimes,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return OvertimeApprovalHistoryState(
      status: status ?? this.status,
      overtimes: overtimes ?? this.overtimes,
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
        overtimes,
        hasReachedMax,
        currentStateFilter,
        currentTypeFilter,
        currentDateFilter,
        searchQuery,
        listTypes,
        page,
      ];
}
