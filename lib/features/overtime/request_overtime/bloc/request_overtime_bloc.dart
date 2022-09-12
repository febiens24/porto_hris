import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_overtime_event.dart';
part 'request_overtime_state.dart';

class RequestOvertimeBloc
    extends Bloc<RequestOvertimeEvent, RequestOvertimeState> {
  RequestOvertimeBloc() : super(RequestOvertimeInitial()) {
    on<SubmitOvertime>(_onSubmitOvertime);
  }

  FutureOr<void> _onSubmitOvertime(
    SubmitOvertime event,
    Emitter<RequestOvertimeState> emit,
  ) async {
    emit(SubmitOvertimeLoading());

    await Future.delayed(const Duration(seconds: 10), () {
      emit(SubmitOvertimeSuccess());
    });
  }
}
