import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/attendance_entity.dart';
import '../../domain/usecases/get_attendance_approval_list_usecase.dart';

part 'attendance_approval_event.dart';
part 'attendance_approval_state.dart';

class AttendanceApprovalBloc
    extends Bloc<AttendanceApprovalEvent, AttendanceApprovalState> {
  final GetAttendanceApprovalListUsecase getAttendanceApprovalList;
  AttendanceApprovalBloc({
    required this.getAttendanceApprovalList,
  }) : super(AttendanceApprovalInitial()) {
    on<AttendanceApprovalEvent>(_onLoadAttendanceApprovalList);
  }

  FutureOr<void> _onLoadAttendanceApprovalList(
    AttendanceApprovalEvent event,
    Emitter<AttendanceApprovalState> emit,
  ) async {
    emit(AttendanceApprovalLoading());
    try {
      final attendanceApprovals = await getAttendanceApprovalList();
      attendanceApprovals.fold(
        (l) {
          emit(AttendanceApprovalLoadFailure(l));
        },
        (r) {
          emit(AttendanceApprovalLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        AttendanceApprovalLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
