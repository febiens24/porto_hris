import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../leave/leave_page/bloc/leave_bloc.dart';

import '../../domain/entities/reprimand_entity.dart';
import '../../domain/usecases/get_reprimand_approval_history_list_usecase.dart';

part 'reprimand_approval_history_event.dart';
part 'reprimand_approval_history_state.dart';

class ReprimandApprovalHistoryBloc
    extends Bloc<ReprimandApprovalHistoryEvent, ReprimandApprovalHistoryState> {
  ReprimandApprovalHistoryBloc({
    required this.getReprimandApprovalHistoryList,
  }) : super(const ReprimandApprovalHistoryState()) {
    on<LoadReprimandApprovalHistoryList>(
      _onLoadReprimandApprovalHistoryList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final GetReprimandApprovalHistoryListUsecase getReprimandApprovalHistoryList;

  FutureOr<void> _onLoadReprimandApprovalHistoryList(
    LoadReprimandApprovalHistoryList event,
    Emitter<ReprimandApprovalHistoryState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ReprimandApprovalHistoryListStatus.initial) {
        final reprimandData = await getReprimandApprovalHistoryList();
        reprimandData.fold(
          (l) {
            emit(state.copyWith(
                status: ReprimandApprovalHistoryListStatus.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: ReprimandApprovalHistoryListStatus.success,
              reprimands: r.result,
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
        final reprimandData = await getReprimandApprovalHistoryList(
          status: event.status,
          type: event.type,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        reprimandData.fold(
          (l) {
            emit(state.copyWith(
                status: ReprimandApprovalHistoryListStatus.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: ReprimandApprovalHistoryListStatus.success,
                    reprimands: List.of(state.reprimands)..addAll(r.result!),
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
      emit(state.copyWith(status: ReprimandApprovalHistoryListStatus.failure));
    }
  }
}
