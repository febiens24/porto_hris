part of 'overtime_list_bloc.dart';

// abstract class OvertimeListState extends Equatable {
//   const OvertimeListState();

//   @override
//   List<Object> get props => [];
// }

// class OvertimeListInitial extends OvertimeListState {}

// class OvertimeListLoading extends OvertimeListState {}

// class OvertimeListLoadSuccess extends OvertimeListState {
//   final OvertimeEntity overtimeList;

//   const OvertimeListLoadSuccess(this.overtimeList);

//   @override
//   List<Object> get props => [overtimeList];
// }

// class OvertimeListLoadFailure extends OvertimeListState {
//   final Map<String, dynamic> errors;

//   const OvertimeListLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum OvertimeListStatus { initial, success, failure }

class OvertimeListState extends Equatable {
  final OvertimeListStatus status;
  final List<OvertimeResultEntity> overtimes;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const OvertimeListState({
    this.status = OvertimeListStatus.initial,
    this.overtimes = const <OvertimeResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  OvertimeListState copyWith({
    OvertimeListStatus? status,
    List<OvertimeResultEntity>? overtimes,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return OvertimeListState(
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
