import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/business_trip_detail_entity.dart';
import '../../domain/usecases/get_business_trip_detail_usecase.dart';

part 'business_trip_detail_event.dart';
part 'business_trip_detail_state.dart';

class BusinessTripDetailBloc
    extends Bloc<BusinessTripDetailEvent, BusinessTripDetailState> {
  final GetBusinessTripDetailUsecase getBusinessTripDetail;

  BusinessTripDetailBloc({
    required this.getBusinessTripDetail,
  }) : super(BusinessTripDetailInitial()) {
    on<LoadBusinessTripDetail>(_onLoadBusinessTripDetail);
  }

  void _onLoadBusinessTripDetail(
    LoadBusinessTripDetail event,
    Emitter<BusinessTripDetailState> emit,
  ) async {
    emit(BusinessTripDetailLoadInProgress());
    try {
      final leaveData = await getBusinessTripDetail(event.businessTripId);
      leaveData.fold(
        (l) {
          emit(BusinessTripDetailLoadFailed(l));
        },
        (r) {
          emit(BusinessTripDetailLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        BusinessTripDetailLoadFailed({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
