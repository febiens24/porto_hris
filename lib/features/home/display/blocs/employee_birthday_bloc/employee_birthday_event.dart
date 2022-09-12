part of 'employee_birthday_bloc.dart';

abstract class EmployeeBirthdayEvent extends Equatable {
  const EmployeeBirthdayEvent();

  @override
  List<Object> get props => [];
}

class LoadEmployeeBirthday extends EmployeeBirthdayEvent {}
