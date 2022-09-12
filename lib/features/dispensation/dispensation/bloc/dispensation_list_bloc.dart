import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../leave/leave_page/bloc/leave_bloc.dart';
import '../../domain/entities/dispensation_entity.dart';
import '../../domain/usecases/get_dispensation_list_usecase.dart';

part 'dispensation_list_event.dart';
part 'dispensation_list_state.dart';

class DispensationListBloc
    extends Bloc<DispensationListEvent, DispensationListState> {
  final GetDispensationListUsecase getDispensationList;
  DispensationListBloc({
    required this.getDispensationList,
  }) : super(const DispensationListState()) {
    on<LoadDispensationList>(
      _onLoadDispensationList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  void _onLoadDispensationList(
    LoadDispensationList event,
    Emitter<DispensationListState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == DispensationListStatus.initial) {
        final businessTripData = await getDispensationList();
        businessTripData.fold(
          (l) {
            emit(state.copyWith(status: DispensationListStatus.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: DispensationListStatus.success,
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
        final dispensationData = await getDispensationList(
          status: event.status,
          type: state.currentTypeFilter,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        dispensationData.fold(
          (l) {
            emit(state.copyWith(status: DispensationListStatus.failure));
          },
          (r) {
            emit(r.result.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: DispensationListStatus.success,
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
      emit(state.copyWith(status: DispensationListStatus.failure));
    }
  }
}
