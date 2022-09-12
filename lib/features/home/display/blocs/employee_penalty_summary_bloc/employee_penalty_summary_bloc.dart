import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/get_employee_penalty_summary.dart';

import '../../../domain/entities/employee_penalty_summary_entity.dart';

part 'employee_penalty_summary_event.dart';
part 'employee_penalty_summary_state.dart';

class EmployeePenaltySummaryBloc
    extends Bloc<EmployeePenaltySummaryEvent, EmployeePenaltySummaryState> {
  EmployeePenaltySummaryBloc({
    required this.getEmployeePenaltySummary,
  }) : super(EmployeePenaltySummaryInitial()) {
    on<LoadEmployeePenaltySummary>(_onLoadEmployeePenaltySummary);
  }

  final GetEmployeePenaltySummary getEmployeePenaltySummary;

  FutureOr<void> _onLoadEmployeePenaltySummary(
    LoadEmployeePenaltySummary event,
    Emitter<EmployeePenaltySummaryState> emit,
  ) async {
    emit(EmployeePenaltySummaryLoading());
    try {
      final employeeBirthday = await getEmployeePenaltySummary();
      employeeBirthday.fold(
        (l) {
          emit(EmployeePenaltySummaryLoadFailure(l));
        },
        (r) {
          emit(EmployeePenaltySummaryLoadSuccess(penaltySummary: r));
        },
      );
    } catch (e) {
      print(e);
      emit(
        EmployeePenaltySummaryLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
