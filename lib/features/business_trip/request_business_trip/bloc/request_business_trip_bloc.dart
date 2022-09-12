import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_business_trip_event.dart';
part 'request_business_trip_state.dart';

class RequestBusinessTripBloc
    extends Bloc<RequestBusinessTripEvent, RequestBusinessTripState> {
  RequestBusinessTripBloc() : super(RequestBusinessTripInitial()) {
    on<SubmitBusinessTrip>(_onRequestBusinessTrip);
  }

  FutureOr<void> _onRequestBusinessTrip(
    SubmitBusinessTrip event,
    Emitter<RequestBusinessTripState> emit,
  ) async {
    emit(SubmitBusinessTripLoading());

    await Future.delayed(const Duration(seconds: 10), () {
      emit(SubmitBusinessTripSuccess());
    });
  }
}
