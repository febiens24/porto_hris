import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../leave/leave_page/bloc/leave_bloc.dart';
import '../../domain/entities/dispensation_entity.dart';
import '../../domain/usecases/get_dispensation_approval_history_list_usecase.dart';

part 'dispensation_approval_history_event.dart';
part 'dispensation_approval_history_state.dart';

class DispensationApprovalHistoryBloc extends Bloc<
    DispensationApprovalHistoryEvent, DispensationApprovalHistoryState> {
  DispensationApprovalHistoryBloc({
    required this.getDispensationApprovalHistoryList,
  }) : super(const DispensationApprovalHistoryState()) {
    on<LoadDispensationApprovalHistoryList>(
      _onLoadDispensationApprovalHistoryList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final GetDispensationApprovalHistoryListUsecase
      getDispensationApprovalHistoryList;

  FutureOr<void> _onLoadDispensationApprovalHistoryList(
    LoadDispensationApprovalHistoryList event,
    Emitter<DispensationApprovalHistoryState> emit,
  ) async {
    // emit(DispensationApprovalHistoryLoading());
    // try {
    //   final attendanceApprovals = await getDispensationApprovalHistoryList();
    //   attendanceApprovals.fold(
    //     (l) {
    //       emit(DispensationApprovalHistoryLoadFailure(l));
    //     },
    //     (r) {
    //       emit(DispensationApprovalHistoryLoadSuccess(r));
    //     },
    //   );
    // } catch (e) {
    //   emit(
    //     DispensationApprovalHistoryLoadFailure({
    //       "status": 'error',
    //       "result": e.toString(),
    //     }),
    //   );
    // }
    if (state.hasReachedMax) return;
    try {
      if (state.status == DispensationApprovalHistoryStatus.initial) {
        final businessTripData = await getDispensationApprovalHistoryList();
        businessTripData.fold(
          (l) {
            emit(state.copyWith(
                status: DispensationApprovalHistoryStatus.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: DispensationApprovalHistoryStatus.success,
              dispensations: r.result,
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
        final dispensationData = await getDispensationApprovalHistoryList(
          status: event.status,
          type: state.currentTypeFilter,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        dispensationData.fold(
          (l) {
            emit(state.copyWith(
                status: DispensationApprovalHistoryStatus.failure));
          },
          (r) {
            emit(r.result.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: DispensationApprovalHistoryStatus.success,
                    dispensations: List.of(state.dispensations)
                      ..addAll(r.result),
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
      emit(state.copyWith(status: DispensationApprovalHistoryStatus.failure));
    }
  }
}
