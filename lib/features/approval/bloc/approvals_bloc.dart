import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/entities/approvals_entity.dart';
import '../domain/usecases/get_approvals_count_usecase.dart';

part 'approvals_event.dart';
part 'approvals_state.dart';

class ApprovalsBloc extends Bloc<ApprovalsEvent, ApprovalsState> {
  ApprovalsBloc({required this.getApprovalsCount}) : super(ApprovalsInitial()) {
    on<ApprovalsEvent>(_onGetApprovalsCount);
  }

  final GetApprovalsCountUsecase getApprovalsCount;

  FutureOr<void> _onGetApprovalsCount(
    ApprovalsEvent event,
    Emitter<ApprovalsState> emit,
  ) async {
    emit(ApprovalsLoadInProgress());
    try {
      final attendanceData = await getApprovalsCount();
      attendanceData.fold(
        (l) {
          emit(ApprovalsLoadFailed(l));
        },
        (r) {
          emit(ApprovalsLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        ApprovalsLoadFailed({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
