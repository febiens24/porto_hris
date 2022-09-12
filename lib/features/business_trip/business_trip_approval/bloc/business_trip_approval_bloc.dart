import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/business_trip_entity.dart';
import '../../domain/usecases/get_business_trip_approval_list.dart';

part 'business_trip_approval_event.dart';
part 'business_trip_approval_state.dart';

class BusinessTripApprovalBloc
    extends Bloc<BusinessTripApprovalEvent, BusinessTripApprovalState> {
  final GetBusinessTripApprovalListUsecase getBusinessTripApproval;
  BusinessTripApprovalBloc({
    required this.getBusinessTripApproval,
  }) : super(BusinessTripApprovalInitial()) {
    on<BusinessTripApprovalEvent>(_onLoadBusinessTripApprovalList);
  }

  FutureOr<void> _onLoadBusinessTripApprovalList(
    BusinessTripApprovalEvent event,
    Emitter<BusinessTripApprovalState> emit,
  ) async {
    emit(BusinessTripApprovalLoading());
    try {
      final businessTripData = await getBusinessTripApproval();
      businessTripData.fold(
        (l) {
          emit(BusinessTripApprovalLoadFailure(l));
        },
        (r) {
          emit(BusinessTripApprovalLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        BusinessTripApprovalLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
