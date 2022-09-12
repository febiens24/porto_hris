part of 'leave_bloc.dart';

// abstract class LeaveState extends Equatable {
//   const LeaveState();

//   @override
//   List<Object> get props => [];
// }

// class LeaveInitial extends LeaveState {}

// class LeaveLoading extends LeaveState {}

// class LeaveLoadSuccess extends LeaveState {
// final LeaveEntity leaveEntity;

//   const LeaveLoadSuccess(this.leaveEntity);

//   @override
//   List<Object> get props => [leaveEntity];
// }

// class LeaveError extends LeaveState {
//   final Map<String, dynamic> errorMsg;

//   const LeaveError(this.errorMsg);

//   @override
//   List<Object> get props => [errorMsg];
// }

enum LeaveStatus { initial, success, failure }

class LeaveState extends Equatable {
  final LeaveStatus status;
  final List<LeaveResultEntity> leaves;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const LeaveState({
    this.status = LeaveStatus.initial,
    this.leaves = const <LeaveResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  LeaveState copyWith({
    LeaveStatus? status,
    List<LeaveResultEntity>? leaves,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return LeaveState(
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
