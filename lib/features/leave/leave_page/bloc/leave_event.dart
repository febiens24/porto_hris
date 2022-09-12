part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object> get props => [];
}

class LoadLeaveList extends LeaveEvent {
  final String? status;
  final String? type;
  final String? dateFilter;
  final String? q;
  final int? page;

  const LoadLeaveList({
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
