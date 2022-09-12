import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/employee_attendance_summary_entity.dart';
import '../../../domain/usecases/get_employee_attendance_summary.dart';

part 'employee_attendance_event.dart';
part 'employee_attendance_state.dart';

class EmployeeAttendanceBloc
    extends Bloc<EmployeeAttendanceEvent, EmployeeAttendanceState> {
  EmployeeAttendanceBloc({
    required this.getEmployeeAttendanceSummary,
  }) : super(EmployeeAttendanceInitial()) {
    on<LoadEmployeeAttendanceSummary>(_onLoadEmployeeAttendanceSummary);
  }

  final GetEmployeeAttendanceSummary getEmployeeAttendanceSummary;

  FutureOr<void> _onLoadEmployeeAttendanceSummary(
    LoadEmployeeAttendanceSummary event,
    Emitter<EmployeeAttendanceState> emit,
  ) async {
    emit(EmployeeAttendanceLoading());
    try {
      final attendanceSummary = await getEmployeeAttendanceSummary();
      attendanceSummary.fold(
        (l) {
          emit(EmployeeAttendanceLoadFailure(l));
        },
        (r) {
          emit(EmployeeAttendanceLoadSuccess(attendanceSummary: r));
        },
      );
    } catch (e) {
      print(e);
      emit(
        EmployeeAttendanceLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
