part of 'dispensation_approval_history_bloc.dart';

// abstract class DispensationApprovalHistoryState extends Equatable {
//   const DispensationApprovalHistoryState();

//   @override
//   List<Object> get props => [];
// }

// class DispensationApprovalHistoryInitial
//     extends DispensationApprovalHistoryState {}

// class DispensationApprovalHistoryLoading
//     extends DispensationApprovalHistoryState {}

// class DispensationApprovalHistoryLoadSuccess
//     extends DispensationApprovalHistoryState {
//   final DispensationEntity dispensationApprovalHistory;

//   const DispensationApprovalHistoryLoadSuccess(
//       this.dispensationApprovalHistory);

//   @override
//   List<Object> get props => [dispensationApprovalHistory];
// }

// class DispensationApprovalHistoryLoadFailure
//     extends DispensationApprovalHistoryState {
//   final Map<String, dynamic> errors;

//   const DispensationApprovalHistoryLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum DispensationApprovalHistoryStatus { initial, success, failure }

class DispensationApprovalHistoryState extends Equatable {
  final DispensationApprovalHistoryStatus status;
  final List<DispensationResultEntity> dispensations;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const DispensationApprovalHistoryState({
    this.status = DispensationApprovalHistoryStatus.initial,
    this.dispensations = const <DispensationResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  DispensationApprovalHistoryState copyWith({
    DispensationApprovalHistoryStatus? status,
    List<DispensationResultEntity>? dispensations,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return DispensationApprovalHistoryState(
      status: status ?? this.status,
      dispensations: dispensations ?? this.dispensations,
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
        dispensations,
        hasReachedMax,
        currentStateFilter,
        currentTypeFilter,
        currentDateFilter,
        searchQuery,
        page,
      ];
}
