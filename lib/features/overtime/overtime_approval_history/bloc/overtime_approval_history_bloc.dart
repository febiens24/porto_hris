import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../leave/leave_page/bloc/leave_bloc.dart';
import '../../domain/entities/overtime_entity.dart';
import '../../domain/usecases/get_overtime_approval_history_list_usecase.dart';

part 'overtime_approval_history_event.dart';
part 'overtime_approval_history_state.dart';

class OvertimeApprovalHistoryBloc
    extends Bloc<OvertimeApprovalHistoryEvent, OvertimeApprovalHistoryState> {
  OvertimeApprovalHistoryBloc({
    required this.getOvertimeApprovalHistoryList,
  }) : super(const OvertimeApprovalHistoryState()) {
    on<LoadOvertimeApprovalHistoryList>(
      _onLoadOvertimeApprovalHistory,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final GetOvertimeApprovalHistoryListUsecase getOvertimeApprovalHistoryList;

  FutureOr<void> _onLoadOvertimeApprovalHistory(
    LoadOvertimeApprovalHistoryList event,
    Emitter<OvertimeApprovalHistoryState> emit,
  ) async {
    // emit(OvertimeApprovalHistoryLoading());
    // try {
    //   final overtimeApprovals = await getOvertimeApprovalHistoryList();
    //   overtimeApprovals.fold(
    //     (l) {
    //       emit(OvertimeApprovalHistoryLoadFailure(l));
    //     },
    //     (r) {
    //       emit(OvertimeApprovalHistoryLoadSuccess(r));
    //     },
    //   );
    // } catch (e) {
    //   emit(
    //     OvertimeApprovalHistoryLoadFailure({
    //       "status": 'error',
    //       "result": e.toString(),
    //     }),
    //   );
    // }
    if (state.hasReachedMax) return;
    try {
      if (state.status == OvertimeApprovalHistoryListStatus.initial) {
        final overtimeData = await getOvertimeApprovalHistoryList();
        overtimeData.fold(
          (l) {
            emit(state.copyWith(
                status: OvertimeApprovalHistoryListStatus.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: OvertimeApprovalHistoryListStatus.success,
              overtimes: r.result,
              hasReachedMax: false,
              currentStateFilter: state.currentStateFilter,
              currentDateFilter: state.currentDateFilter,
              currentTypeFilter: state.currentTypeFilter,
              listTypes: r.types,
              page: state.page,
              searchQuery: state.searchQuery,
            ));
          },
        );
      } else {
        final overtimeData = await getOvertimeApprovalHistoryList(
          status: event.status,
          type: event.type,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        overtimeData.fold(
          (l) {
            emit(state.copyWith(
                status: OvertimeApprovalHistoryListStatus.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: OvertimeApprovalHistoryListStatus.success,
                    overtimes: List.of(state.overtimes)..addAll(r.result!),
                    currentStateFilter: event.status,
                    currentDateFilter: event.dateFilter,
                    currentTypeFilter: event.type,
                    searchQuery: event.q,
                    listTypes: r.types,
                  ));
          },
        );
      }
    } catch (_) {
      emit(state.copyWith(status: OvertimeApprovalHistoryListStatus.failure));
    }
  }
}
