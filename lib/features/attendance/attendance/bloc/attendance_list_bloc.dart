import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/attendance_entity.dart';
import '../../domain/usecases/get_attendance_list_usecase.dart';

part 'attendance_list_event.dart';
part 'attendance_list_state.dart';

class AttendanceListBloc
    extends Bloc<AttendanceListEvent, AttendanceListState> {
  final GetAttendanceListUsecase getAttendanceList;
  AttendanceListBloc({
    required this.getAttendanceList,
  }) : super(AttendanceListInitial()) {
    on<LoadAttendanceList>(_onLoadAttendanceList);
  }

  void _onLoadAttendanceList(
    LoadAttendanceList event,
    Emitter<AttendanceListState> emit,
  ) async {
    emit(AttendanceListLoadInProgress());
    try {
      final attendanceData = await getAttendanceList();
      attendanceData.fold(
        (l) {
          emit(AttendanceListLoadFailed(l));
        },
        (r) {
          emit(AttendanceListLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        AttendanceListLoadFailed({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
