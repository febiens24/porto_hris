part of 'dispensation_list_bloc.dart';

// abstract class DispensationListState extends Equatable {
//   const DispensationListState();

//   @override
//   List<Object> get props => [];
// }

// class DispensationListInitial extends DispensationListState {}

// class DispensationLoading extends DispensationListState {}

// class DispensationLoadSuccess extends DispensationListState {
//   final DispensationEntity dispensations;

//   const DispensationLoadSuccess(this.dispensations);

//   @override
//   List<Object> get props => [dispensations];
// }

// class DispensationLoadFailure extends DispensationListState {
//   final Map<String, dynamic> errors;

//   const DispensationLoadFailure(this.errors);

//   @override
//   List<Object> get props => [errors];
// }

enum DispensationListStatus { initial, success, failure }

class DispensationListState extends Equatable {
  final DispensationListStatus status;
  final List<DispensationResultEntity> dispensations;
  final bool hasReachedMax;
  final String currentStateFilter;
  final String currentTypeFilter;
  final String currentDateFilter;
  final String searchQuery;
  final List<dynamic> listTypes;
  final int page;

  const DispensationListState({
    this.status = DispensationListStatus.initial,
    this.dispensations = const <DispensationResultEntity>[],
    this.hasReachedMax = false,
    this.currentStateFilter = 'all',
    this.currentTypeFilter = 'all',
    this.currentDateFilter = 'all',
    this.searchQuery = '',
    this.listTypes = const <dynamic>[],
    this.page = 1,
  });

  DispensationListState copyWith({
    DispensationListStatus? status,
    List<DispensationResultEntity>? dispensations,
    bool? hasReachedMax,
    String? currentStateFilter,
    String? currentTypeFilter,
    String? currentDateFilter,
    String? searchQuery,
    List<dynamic>? listTypes,
    int? page,
  }) {
    return DispensationListState(
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
