import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/employee_birthday_entity.dart';
import '../../../domain/usecases/get_employee_birthday.dart';

part 'employee_birthday_event.dart';
part 'employee_birthday_state.dart';

class EmployeeBirthdayBloc
    extends Bloc<EmployeeBirthdayEvent, EmployeeBirthdayState> {
  EmployeeBirthdayBloc({
    required this.getEmployeeBirthday,
  }) : super(EmployeeBirthdayInitial()) {
    on<LoadEmployeeBirthday>(_onLoadEmployeeBirthday);
  }

  final GetEmployeeBirthday getEmployeeBirthday;

  FutureOr<void> _onLoadEmployeeBirthday(
    LoadEmployeeBirthday event,
    Emitter<EmployeeBirthdayState> emit,
  ) async {
    emit(EmployeeBirthdayLoading());
    try {
      final employeeBirthday = await getEmployeeBirthday();
      employeeBirthday.fold(
        (l) {
          emit(EmployeeBirthdayLoadFailure(l));
        },
        (r) {
          emit(EmployeeBirthdayLoadSuccess(employeeBirthday: r));
        },
      );
    } catch (e) {
      print(e);
      emit(
        EmployeeBirthdayLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
