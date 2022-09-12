part of 'overtime_list_bloc.dart';

abstract class OvertimeListEvent extends Equatable {
  const OvertimeListEvent();

  @override
  List<Object> get props => [];
}

class LoadOvertimeList extends OvertimeListEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadOvertimeList({
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
