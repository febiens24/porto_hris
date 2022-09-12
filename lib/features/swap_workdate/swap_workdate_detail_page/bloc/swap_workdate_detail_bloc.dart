import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/swap_workdate_detail_entity.dart';
import '../../domain/usecases/get_swap_workdate_detail_usecase.dart';

part 'swap_workdate_detail_event.dart';
part 'swap_workdate_detail_state.dart';

class SwapWorkdateDetailBloc
    extends Bloc<SwapWorkdateDetailEvent, SwapWorkdateDetailState> {
  final GetSwapWorkdateDetailUsecase getSwapWorkdateDetail;
  SwapWorkdateDetailBloc({
    required this.getSwapWorkdateDetail,
  }) : super(SwapWorkdateDetailInitial()) {
    on<LoadSwapWorkdateDetail>(_onLoadReprimandDetail);
  }

  FutureOr<void> _onLoadReprimandDetail(
    LoadSwapWorkdateDetail event,
    Emitter<SwapWorkdateDetailState> emit,
  ) async {
    emit(SwapWorkdateDetailLoading());
    try {
      final reprimandData = await getSwapWorkdateDetail(event.swapWorkdateId);
      reprimandData.fold(
        (l) {
          emit(SwapWorkdateDetailLoadFailure(l));
        },
        (r) {
          emit(SwapWorkdateDetailLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        SwapWorkdateDetailLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
