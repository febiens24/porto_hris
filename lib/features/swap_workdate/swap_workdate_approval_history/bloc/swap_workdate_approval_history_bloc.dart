import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../leave/leave_page/bloc/leave_bloc.dart';
import '../../domain/entities/swap_workdate_entity.dart';
import '../../domain/usecases/get_swap_workdate_approval_history_list.dart';

part 'swap_workdate_approval_history_event.dart';
part 'swap_workdate_approval_history_state.dart';

class SwapWorkdateApprovalHistoryBloc extends Bloc<
    SwapWorkdateApprovalHistoryEvent, SwapWorkdateApprovalHistoryState> {
  SwapWorkdateApprovalHistoryBloc({
    required this.getSwapWorkdateApprovalHistoryList,
  }) : super(const SwapWorkdateApprovalHistoryState()) {
    on<LoadSwapWorkdateApprovalHistoryList>(
      _onLoadSwapWorkdateApprovalHistoryList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final GetSwapWorkdateApprovalHistoryListUsecase
      getSwapWorkdateApprovalHistoryList;

  FutureOr<void> _onLoadSwapWorkdateApprovalHistoryList(
    LoadSwapWorkdateApprovalHistoryList event,
    Emitter<SwapWorkdateApprovalHistoryState> emit,
  ) async {
    // emit(SwapWorkdateApprovalHistoryLoading());
    // try {
    //   final reprimandApprovals = await getSwapWorkdateApprovalHistoryList();
    //   reprimandApprovals.fold(
    //     (l) {
    //       emit(SwapWorkdateApprovalHistoryLoadFailure(l));
    //     },
    //     (r) {
    //       emit(SwapWorkdateApprovalHistoryLoadSuccess(r));
    //     },
    //   );
    // } catch (e) {
    //   emit(
    //     SwapWorkdateApprovalHistoryLoadFailure({
    //       "status": 'error',
    //       "result": e.toString(),
    //     }),
    //   );
    // }
    if (state.hasReachedMax) return;
    try {
      if (state.status == SwapWorkdateHistoryListStatus.initial) {
        final reprimandData = await getSwapWorkdateApprovalHistoryList();
        reprimandData.fold(
          (l) {
            emit(state.copyWith(status: SwapWorkdateHistoryListStatus.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: SwapWorkdateHistoryListStatus.success,
              swapworkdates: r.result,
              hasReachedMax: false,
              currentStateFilter: state.currentStateFilter,
              currentDateFilter: state.currentDateFilter,
              page: state.page,
              searchQuery: state.searchQuery,
            ));
          },
        );
      } else {
        final reprimandData = await getSwapWorkdateApprovalHistoryList(
          status: event.status,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        reprimandData.fold(
          (l) {
            emit(state.copyWith(status: SwapWorkdateHistoryListStatus.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: SwapWorkdateHistoryListStatus.success,
                    swapworkdates: List.of(state.swapworkdates)
                      ..addAll(r.result!),
                    currentStateFilter: event.status,
                    currentDateFilter: event.dateFilter,
                    searchQuery: event.q,
                  ));
          },
        );
      }
    } catch (_) {
      emit(state.copyWith(status: SwapWorkdateHistoryListStatus.failure));
    }
  }
}
