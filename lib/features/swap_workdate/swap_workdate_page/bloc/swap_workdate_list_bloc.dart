import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../leave/leave_page/bloc/leave_bloc.dart';
import '../../domain/entities/swap_workdate_entity.dart';
import '../../domain/usecases/get_swap_workdate_list_usecase.dart';

part 'swap_workdate_list_event.dart';
part 'swap_workdate_list_state.dart';

class SwapWorkdateListBloc
    extends Bloc<SwapWorkdateListEvent, SwapWorkdateListState> {
  final GetSwapWorkdateListUsecase getSwapWorkdateList;
  SwapWorkdateListBloc({
    required this.getSwapWorkdateList,
  }) : super(const SwapWorkdateListState()) {
    on<LoadSwapWorkdateList>(
      _onLoadReprimandList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  FutureOr<void> _onLoadReprimandList(
    LoadSwapWorkdateList event,
    Emitter<SwapWorkdateListState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == SwapWordateListState.initial) {
        final swapWorkdateData = await getSwapWorkdateList();
        swapWorkdateData.fold(
          (l) {
            emit(state.copyWith(status: SwapWordateListState.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: SwapWordateListState.success,
              swapWorkdates: r.result,
              hasReachedMax: false,
              currentStateFilter: state.currentStateFilter,
              currentDateFilter: state.currentDateFilter,
            ));
          },
        );
      } else {
        final swapWorkdateData = await getSwapWorkdateList(
          status: event.status,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: 'asd',
          page: state.swapWorkdates.length,
        );
        swapWorkdateData.fold(
          (l) {
            emit(state.copyWith(status: SwapWordateListState.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: SwapWordateListState.success,
                    swapWorkdates: List.of(state.swapWorkdates)
                      ..addAll(r.result!),
                    currentStateFilter: event.status,
                    currentDateFilter: event.dateFilter,
                  ));
          },
        );
      }
    } catch (_) {
      emit(state.copyWith(status: SwapWordateListState.failure));
    }
  }
}
