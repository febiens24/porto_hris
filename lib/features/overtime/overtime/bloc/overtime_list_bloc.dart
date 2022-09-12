import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../leave/leave_page/bloc/leave_bloc.dart';
import '../../domain/entities/overtime_entity.dart';
import '../../domain/usecases/get_overtime_list_usecase.dart';

part 'overtime_list_event.dart';
part 'overtime_list_state.dart';

class OvertimeListBloc extends Bloc<OvertimeListEvent, OvertimeListState> {
  final GetOvertimeListUsecase getOvertimeList;
  OvertimeListBloc({
    required this.getOvertimeList,
  }) : super(const OvertimeListState()) {
    on<LoadOvertimeList>(
      _onLoadOvertimeList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  void _onLoadOvertimeList(
    LoadOvertimeList event,
    Emitter<OvertimeListState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == OvertimeListStatus.initial) {
        final overtimeData = await getOvertimeList();
        overtimeData.fold(
          (l) {
            emit(state.copyWith(status: OvertimeListStatus.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: OvertimeListStatus.success,
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
        final overtimeData = await getOvertimeList(
          status: event.status,
          type: event.type,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        overtimeData.fold(
          (l) {
            emit(state.copyWith(status: OvertimeListStatus.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: OvertimeListStatus.success,
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
      emit(state.copyWith(status: OvertimeListStatus.failure));
    }
  }
}
