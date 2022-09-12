part of 'employee_birthday_bloc.dart';

abstract class EmployeeBirthdayState extends Equatable {
  const EmployeeBirthdayState();

  @override
  List<Object> get props => [];
}

class EmployeeBirthdayInitial extends EmployeeBirthdayState {}

class EmployeeBirthdayLoading extends EmployeeBirthdayState {}

class EmployeeBirthdayLoadSuccess extends EmployeeBirthdayState {
  final EmployeeBirthdayEntity employeeBirthday;

  const EmployeeBirthdayLoadSuccess({
    required this.employeeBirthday,
  });

  @override
  List<Object> get props => [employeeBirthday];
}

class EmployeeBirthdayLoadFailure extends EmployeeBirthdayState {
  final Map<String, dynamic> errorMsg;

  const EmployeeBirthdayLoadFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
