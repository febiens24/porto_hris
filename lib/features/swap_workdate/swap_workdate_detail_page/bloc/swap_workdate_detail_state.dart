part of 'swap_workdate_detail_bloc.dart';

abstract class SwapWorkdateDetailState extends Equatable {
  const SwapWorkdateDetailState();

  @override
  List<Object> get props => [];
}

class SwapWorkdateDetailInitial extends SwapWorkdateDetailState {}

class SwapWorkdateDetailLoading extends SwapWorkdateDetailState {}

class SwapWorkdateDetailLoadSuccess extends SwapWorkdateDetailState {
  final SwapWorkdateDetailEntity swapWorkdateDetail;

  const SwapWorkdateDetailLoadSuccess(this.swapWorkdateDetail);

  @override
  List<Object> get props => [swapWorkdateDetail];
}

class SwapWorkdateDetailLoadFailure extends SwapWorkdateDetailState {
  final Map<String, dynamic> errors;

  const SwapWorkdateDetailLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
