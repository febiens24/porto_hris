import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/attendance_entity.dart';
import '../../domain/usecases/get_attendance_approval_history_usecase.dart';

part 'attendance_approval_history_event.dart';
part 'attendance_approval_history_state.dart';

class AttendanceApprovalHistoryBloc extends Bloc<AttendanceApprovalHistoryEvent,
    AttendanceApprovalHistoryState> {
  final GetAttendanceApprovalHistoryListUsecase
      getAttendanceApprovalHistoryList;
  AttendanceApprovalHistoryBloc({
    required this.getAttendanceApprovalHistoryList,
  }) : super(AttendanceApprovalHistoryInitial()) {
    on<AttendanceApprovalHistoryEvent>(_onLoadAttendanceApprovalHistory);
  }

  FutureOr<void> _onLoadAttendanceApprovalHistory(
    AttendanceApprovalHistoryEvent event,
    Emitter<AttendanceApprovalHistoryState> emit,
  ) async {
    emit(AttendanceApprovalHistoryLoading());
    try {
      final attendanceApprovals = await getAttendanceApprovalHistoryList();
      attendanceApprovals.fold(
        (l) {
          emit(AttendanceApprovalHistoryLoadFailure(l));
        },
        (r) {
          emit(AttendanceApprovalHistoryLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        AttendanceApprovalHistoryLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
