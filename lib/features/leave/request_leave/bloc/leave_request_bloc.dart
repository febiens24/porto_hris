import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/leave_types_entity.dart';
import '../../domain/usecases/get_leave_types_usecase.dart';

part 'leave_request_event.dart';
part 'leave_request_state.dart';

class LeaveRequestBloc extends Bloc<LeaveRequestEvent, LeaveRequestState> {
  final GetLeaveTypesUsecase getLeaveTypes;
  LeaveRequestBloc({
    required this.getLeaveTypes,
  }) : super(LeaveRequestInitial()) {
    on<LeaveRequestEvent>(_onLoadLeaveTypes);
    on<SubmitRequest>(_onSubmitRequest);
  }

  void _onLoadLeaveTypes(
    LeaveRequestEvent event,
    Emitter<LeaveRequestState> emit,
  ) async {
    emit(LeaveTypesLoadInProgress());
    try {
      final leaveTypesData = await getLeaveTypes();
      leaveTypesData.fold(
        (l) {
          emit(LeaveTypesLoadFailed(l));
        },
        (r) {
          emit(LeaveTypesLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        LeaveTypesLoadFailed({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }

  FutureOr<void> _onSubmitRequest(
    SubmitRequest event,
    Emitter<LeaveRequestState> emit,
  ) async {
    emit(SubmitLeaveLoading());
    await Future.delayed(const Duration(seconds: 10), () {
      emit(SubmitLeaveSuccess());
    });
  }
}
