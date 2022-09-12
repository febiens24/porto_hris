part of 'dispensation_list_bloc.dart';

abstract class DispensationListEvent extends Equatable {
  const DispensationListEvent();

  @override
  List<Object> get props => [];
}

class LoadDispensationList extends DispensationListEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadDispensationList({
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
