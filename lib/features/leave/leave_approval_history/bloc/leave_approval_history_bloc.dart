import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/leave_entity.dart';
import '../../domain/usecases/get_leave_approval_history_list_usecase.dart';
import '../../leave_page/bloc/leave_bloc.dart';

part 'leave_approval_history_event.dart';
part 'leave_approval_history_state.dart';

class LeaveApprovalHistoryBloc
    extends Bloc<LeaveApprovalHistoryEvent, LeaveApprovalHistoryState> {
  LeaveApprovalHistoryBloc({
    required this.getLeaveApprovalHistoryList,
  }) : super(const LeaveApprovalHistoryState()) {
    on<LoadLeaveApprovalHistoryList>(
      _onLoadApprovalHistoryList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final GetLeaveApprovalHistoryListUsecase getLeaveApprovalHistoryList;

  FutureOr<void> _onLoadApprovalHistoryList(
    LoadLeaveApprovalHistoryList event,
    Emitter<LeaveApprovalHistoryState> emit,
  ) async {
    // emit(LeaveApprovalHistoryLoading());
    // try {
    //   final attendanceApprovals = await getLeaveApprovalHistoryList();
    //   attendanceApprovals.fold(
    //     (l) {
    //       emit(LeaveApprovalHistoryLoadFailure(l));
    //     },
    //     (r) {
    //       emit(LeaveApprovalHistoryLoadSuccess(r));
    //     },
    //   );
    // } catch (e) {
    //   emit(
    //     LeaveApprovalHistoryLoadFailure({
    //       "status": 'error',
    //       "result": e.toString(),
    //     }),
    //   );
    // }
    if (state.hasReachedMax) return;
    try {
      if (state.status == LeaveStatus.initial) {
        final leaveData = await getLeaveApprovalHistoryList();
        leaveData.fold(
          (l) {
            emit(state.copyWith(status: LeaveApprovalHistoryStatus.failure));
          },
          (r) {
            emit(state.copyWith(
              status: LeaveApprovalHistoryStatus.success,
              leaves: r.result,
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
        final leaveData = await getLeaveApprovalHistoryList(
          status: event.status,
          type: event.type,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        leaveData.fold(
          (l) {
            emit(state.copyWith(status: LeaveApprovalHistoryStatus.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: LeaveApprovalHistoryStatus.success,
                    leaves: List.of(state.leaves)..addAll(r.result!),
                    currentStateFilter: event.status,
                    currentDateFilter: event.dateFilter,
                    currentTypeFilter: event.type,
                    searchQuery: event.q,
                    listTypes: r.types,
                  ));
          },
        );
      }
    } catch (e) {
      emit(state.copyWith(status: LeaveApprovalHistoryStatus.failure));
    }
  }
}
