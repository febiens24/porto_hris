part of 'reprimand_list_bloc.dart';

// abstract class ReprimandListState extends Equatable {
//   const ReprimandListState();

//   @override
//   List<Object> get props => [];
// }

// class ReprimandListInitial extends ReprimandListState {}

// class ReprimandListLoading extends ReprimandListState {}

// class ReprimandListLoadSuccess extends ReprimandListState {
//   final ReprimandEntity reprimandList;

//   const ReprimandListLoadSuccess(this.reprimandList);

//   @override
//   List<Object> get props => [reprimandList];
// }

// class ReprimandListLoadFailure extends ReprimandListState {
//   final Map<String, dynamic> errors;

//   const ReprimandListLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum ReprimandListStatus { initial, success, failure }

class ReprimandListState extends Equatable {
  final ReprimandListStatus status;
  final List<ReprimandResultEntity> reprimands;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const ReprimandListState({
    this.status = ReprimandListStatus.initial,
    this.reprimands = const <ReprimandResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  ReprimandListState copyWith({
    ReprimandListStatus? status,
    List<ReprimandResultEntity>? reprimands,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return ReprimandListState(
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
