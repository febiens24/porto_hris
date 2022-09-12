part of 'reprimand_detail_bloc.dart';

abstract class ReprimandDetailEvent extends Equatable {
  const ReprimandDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadReprimandDetail extends ReprimandDetailEvent {
  final int reprimandId;

  const LoadReprimandDetail(this.reprimandId);

  @override
  List<Object> get props => [reprimandId];
}
