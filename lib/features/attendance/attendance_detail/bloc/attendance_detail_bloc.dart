import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/attendance_detail_entity.dart';
import '../../domain/usecases/get_attendance_detail_usecase.dart';

part 'attendance_detail_event.dart';
part 'attendance_detail_state.dart';

class AttendanceDetailBloc
    extends Bloc<AttendanceDetailEvent, AttendanceDetailState> {
  final GetAttendanceDetailUsecase getAttendanceDetail;
  AttendanceDetailBloc({
    required this.getAttendanceDetail,
  }) : super(AttendanceDetailInitial()) {
    on<LoadAttendanceDetail>(_onLoadLeaveDetail);
  }

  void _onLoadLeaveDetail(
      LoadAttendanceDetail event, Emitter<AttendanceDetailState> emit) async {
    emit(AttendanceDetailLoadInProgress());
    try {
      final attendanceData = await getAttendanceDetail(event.leaveId);
      attendanceData.fold(
        (l) {
          emit(AttendanceDetailLoadFailed(l));
        },
        (r) {
          emit(AttendanceDetailLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        AttendanceDetailLoadFailed({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
