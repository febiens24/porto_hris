import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../domain/entities/leave_entity.dart';
import '../../domain/usecases/get_leave_list_usecase.dart';

part 'leave_event.dart';
part 'leave_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final GetLeaveListUsecase getLeaveList;
  LeaveBloc({
    required this.getLeaveList,
  }) : super(const LeaveState()) {
    on<LoadLeaveList>(
      _onLoadLeaveList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  void _onLoadLeaveList(LoadLeaveList event, Emitter<LeaveState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == LeaveStatus.initial) {
        final leaveData = await getLeaveList();
        leaveData.fold(
          (l) {
            emit(state.copyWith(status: LeaveStatus.failure));
          },
          (r) {
            emit(state.copyWith(
              status: LeaveStatus.success,
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
        final leaveData = await getLeaveList(
          status: event.status,
          type: event.type,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        leaveData.fold(
          (l) {
            emit(state.copyWith(status: LeaveStatus.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: LeaveStatus.success,
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
      emit(state.copyWith(status: LeaveStatus.failure));
    }
  }
}
