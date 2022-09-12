import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../leave/leave_page/bloc/leave_bloc.dart';

import '../../domain/entities/business_trip_entity.dart';
import '../../domain/usecases/get_business_trip_approval_history_usecase.dart';

part 'business_trip_approval_history_event.dart';
part 'business_trip_approval_history_state.dart';

class BusinessTripApprovalHistoryBloc extends Bloc<
    BusinessTripApprovalHistoryEvent, BusinessTripApprovalHistoryState> {
  BusinessTripApprovalHistoryBloc({
    required this.getBusinessTripApprovalHistoryList,
  }) : super(const BusinessTripApprovalHistoryState()) {
    on<LoadBusinessTripApprovalHistory>(
      _onLoadBusinessTripApprovalHistoryList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final GetBusinessTripApprovalHistoryListUsecase
      getBusinessTripApprovalHistoryList;

  FutureOr<void> _onLoadBusinessTripApprovalHistoryList(
    LoadBusinessTripApprovalHistory event,
    Emitter<BusinessTripApprovalHistoryState> emit,
  ) async {
    // emit(BusinessTripApprovalHistoryStatus.());
    // try {
    //   final attendanceApprovals = await getBusinessTripApprovalHistoryList();
    //   attendanceApprovals.fold(
    //     (l) {
    //       emit(BusinessTripApprovalHistoryLoadFailure(l));
    //     },
    //     (r) {
    //       emit(BusinessTripApprovalHistoryLoadSuccess(r));
    //     },
    //   );
    // } catch (e) {
    //   emit(
    //     BusinessTripApprovalHistoryLoadFailure({
    //       "status": 'error',
    //       "result": e.toString(),
    //     }),
    //   );
    // }
    if (state.hasReachedMax) return;
    try {
      if (state.status == BusinessTripApprovalHistoryStatus.initial) {
        final businessTripData = await getBusinessTripApprovalHistoryList();
        businessTripData.fold(
          (l) {
            emit(state.copyWith(
                status: BusinessTripApprovalHistoryStatus.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: BusinessTripApprovalHistoryStatus.success,
              businessTrips: r.result,
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
        final businessTripData = await getBusinessTripApprovalHistoryList(
          status: event.status,
          type: state.currentTypeFilter,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        businessTripData.fold(
          (l) {
            emit(state.copyWith(
                status: BusinessTripApprovalHistoryStatus.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: BusinessTripApprovalHistoryStatus.success,
                    businessTrips: List.of(state.businessTrips)
                      ..addAll(r.result!),
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
      emit(state.copyWith(status: BusinessTripApprovalHistoryStatus.failure));
    }
  }
}
