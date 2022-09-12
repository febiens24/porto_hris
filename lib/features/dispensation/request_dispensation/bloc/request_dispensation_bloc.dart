import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_dispensation_event.dart';
part 'request_dispensation_state.dart';

class RequestDispensationBloc
    extends Bloc<RequestDispensationEvent, RequestDispensationState> {
  RequestDispensationBloc() : super(RequestDispensationInitial()) {
    on<SubmitDispensation>(_onSubmitDispensation);
  }

  FutureOr<void> _onSubmitDispensation(
    SubmitDispensation event,
    Emitter<RequestDispensationState> emit,
  ) async {
    emit(SubmitDispensationLoading());

    await Future.delayed(const Duration(seconds: 10), () {
      emit(SubmitDispensationSuccess());
    });
  }
}
