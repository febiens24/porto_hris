part of 'reprimand_list_bloc.dart';

abstract class ReprimandListEvent extends Equatable {
  const ReprimandListEvent();

  @override
  List<Object> get props => [];
}

class LoadReprimandList extends ReprimandListEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadReprimandList({
    this.status = 'all',
    this.type = 'all',
    this.dateFilter = 'all',
    this.q = '',
    this.page = 1,
  });

  @override
  List<Object> get props => [
        status!,
        type!,
        dateFilter!,
        q!,
        page!,
      ];
}
