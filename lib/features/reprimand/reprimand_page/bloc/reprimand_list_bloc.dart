import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../leave/leave_page/bloc/leave_bloc.dart';
import '../../domain/entities/reprimand_entity.dart';
import '../../domain/usecases/get_reprimand_list_usecase.dart';

part 'reprimand_list_event.dart';
part 'reprimand_list_state.dart';

class ReprimandListBloc extends Bloc<ReprimandListEvent, ReprimandListState> {
  final GetReprimandListUsecase getReprimandList;
  ReprimandListBloc({
    required this.getReprimandList,
  }) : super(const ReprimandListState()) {
    on<LoadReprimandList>(
      _onLoadReprimandList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  FutureOr<void> _onLoadReprimandList(
    LoadReprimandList event,
    Emitter<ReprimandListState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ReprimandListStatus.initial) {
        final reprimandData = await getReprimandList();
        reprimandData.fold(
          (l) {
            emit(state.copyWith(status: ReprimandListStatus.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: ReprimandListStatus.success,
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
        final reprimandData = await getReprimandList(
          status: event.status,
          type: event.type,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        reprimandData.fold(
          (l) {
            emit(state.copyWith(status: ReprimandListStatus.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: ReprimandListStatus.success,
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
      emit(state.copyWith(status: ReprimandListStatus.failure));
    }
  }
}
