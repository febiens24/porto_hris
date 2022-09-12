part of 'swap_workdate_detail_bloc.dart';

abstract class SwapWorkdateDetailEvent extends Equatable {
  const SwapWorkdateDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadSwapWorkdateDetail extends SwapWorkdateDetailEvent {
  final int swapWorkdateId;

  const LoadSwapWorkdateDetail(this.swapWorkdateId);

  @override
  List<Object> get props => [swapWorkdateId];
}
