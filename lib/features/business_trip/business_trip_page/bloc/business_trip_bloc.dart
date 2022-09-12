import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../leave/leave_page/bloc/leave_bloc.dart';
import '../../domain/entities/business_trip_entity.dart';
import '../../domain/usecases/get_business_trip_list_usecase.dart';

part 'business_trip_event.dart';
part 'business_trip_state.dart';

class BusinessTripBloc extends Bloc<BusinessTripEvent, BusinessTripState> {
  final GetBusinessTripListUsecase getBusinessTripList;

  BusinessTripBloc({
    required this.getBusinessTripList,
  }) : super(const BusinessTripState()) {
    on<LoadBusinessTripList>(
      _onLoadBusinessTripList,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  void _onLoadBusinessTripList(
    LoadBusinessTripList event,
    Emitter<BusinessTripState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == BusinessTripStatus.initial) {
        final businessTripData = await getBusinessTripList();
        businessTripData.fold(
          (l) {
            emit(state.copyWith(status: BusinessTripStatus.failure));
          },
          (r) {
            return emit(state.copyWith(
              status: BusinessTripStatus.success,
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
        final businessTripData = await getBusinessTripList(
          status: event.status,
          type: state.currentTypeFilter,
          dateFrom: event.dateFilter,
          dateTo: event.dateFilter,
          q: event.q,
        );
        businessTripData.fold(
          (l) {
            emit(state.copyWith(status: BusinessTripStatus.failure));
          },
          (r) {
            emit(r.result!.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: BusinessTripStatus.success,
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
    } catch (e) {
      print(e);
      emit(state.copyWith(status: BusinessTripStatus.failure));
    }
  }
}
