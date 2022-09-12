part of 'swap_workdate_list_bloc.dart';

abstract class SwapWorkdateListEvent extends Equatable {
  const SwapWorkdateListEvent();

  @override
  List<Object> get props => [];
}

class LoadSwapWorkdateList extends SwapWorkdateListEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadSwapWorkdateList({
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
