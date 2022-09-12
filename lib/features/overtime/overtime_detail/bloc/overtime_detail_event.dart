part of 'overtime_detail_bloc.dart';

abstract class OvertimeDetailEvent extends Equatable {
  const OvertimeDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadOvertimeDetail extends OvertimeDetailEvent {
  final int overtimeId;

  const LoadOvertimeDetail(this.overtimeId);

  @override
  List<Object> get props => [overtimeId];
}
