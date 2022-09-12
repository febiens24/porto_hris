import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../features/home/data/datasources/home_api_services.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/usecases/get_employee_attendance_summary.dart';
import '../features/home/domain/usecases/get_employee_birthday.dart';
import '../features/home/domain/usecases/get_employee_penalty_summary.dart';
import '../features/leave/domain/usecases/get_leave_approval_history_list_usecase.dart';
import '../features/overtime/domain/usecases/get_overtime_approval_history_list_usecase.dart';
import '../features/reprimand/domain/usecases/get_reprimand_approval_history_list_usecase.dart';
import '../features/business_trip/domain/usecases/get_business_trip_approval_history_usecase.dart';
import '../features/dispensation/domain/usecases/get_dispensation_approval_history_list_usecase.dart';
import '../common/networkcall.dart';
import '../features/approval/data/datasources/approvals_api_services.dart';
import '../features/approval/domain/repositories/approvals_repository.dart';
import '../features/attendance/domain/usecases/get_attendance_approval_history_usecase.dart';
import '../features/leave/domain/usecases/approve_leave_request_usecase.dart';
import '../features/leave/domain/usecases/patch_leave_status_usecase.dart';
import '../features/leave/domain/usecases/reject_leave_request_usecase.dart';
import '../features/approval/data/repositories/approvals_repository_impl.dart';
import '../features/approval/domain/usecases/get_approvals_count_usecase.dart';
import '../features/attendance/data/datasources/attendance_api_services.dart';
import '../features/attendance/domain/repositories/attendance_repository.dart';
import '../features/attendance/domain/usecases/get_attendance_approval_list_usecase.dart';
import '../features/attendance/domain/usecases/get_attendance_detail_usecase.dart';
import '../features/attendance/domain/usecases/get_attendance_list_usecase.dart';
import '../features/swap_workdate/data/datasources/swap_workdate_api_services.dart';
import '../features/swap_workdate/data/repositories/swap_workdate_repository_impl.dart';
import '../features/swap_workdate/domain/repositories/swap_workdate_repository.dart';
import '../features/swap_workdate/domain/usecases/get_swap_workdate_approval_history_list.dart';
import '../features/swap_workdate/domain/usecases/get_swap_workdate_approval_list_usecase.dart';
import '../features/swap_workdate/domain/usecases/get_swap_workdate_detail_usecase.dart';
import '../features/swap_workdate/domain/usecases/get_swap_workdate_list_usecase.dart';
import '../features/attendance/data/repositories/attendance_repository_impl.dart';
import '../features/reprimand/data/datasources/reprimand_api_services.dart';
import '../features/reprimand/data/repositories/reprimand_repository_impl.dart';
import '../features/reprimand/domain/repositories/reprimand_repository.dart';
import '../features/reprimand/domain/usecases/get_reprimand_detail_usecase.dart';
import '../features/reprimand/domain/usecases/get_reprimand_list_usecase.dart';
import '../features/business_trip/domain/usecases/get_business_trip_approval_list.dart';
import '../features/dispensation/domain/usecases/get_dispensation_approval_usecase.dart';
import '../features/overtime/domain/usecases/get_overtime_approval_list_usecase.dart';
import '../features/business_trip/data/datasources/business_trip_api_services.dart';
import '../features/business_trip/data/repositories/business_trip_repository_impl.dart';
import '../features/business_trip/domain/repositories/business_trip_repository.dart';
import '../features/business_trip/domain/usecases/get_business_trip_detail_usecase.dart';
import '../features/business_trip/domain/usecases/get_business_trip_list_usecase.dart';
import '../features/dispensation/data/datasource/dispensation_api_services.dart';
import '../features/dispensation/data/repositories/dispensation_repository_impl.dart';
import '../features/dispensation/domain/repositories/dispensation_repository.dart';
import '../features/dispensation/domain/usecases/get_dispensation_detail_usecase.dart';
import '../features/dispensation/domain/usecases/get_dispensation_list_usecase.dart';
import '../features/leave/data/datasources/leave_api_services.dart';
import '../features/leave/data/repositories/leave_repository_impl.dart';
import '../features/leave/domain/repositories/leave_repository.dart';
import '../features/leave/domain/usecases/get_leave_approval_list.dart';
import '../features/leave/domain/usecases/get_leave_detail_usecase.dart';
import '../features/leave/domain/usecases/get_leave_list_usecase.dart';
import '../features/leave/domain/usecases/get_leave_types_usecase.dart';
import '../features/authentication/data/repositories/authentication_repository_impl.dart';
import '../features/authentication/domain/repositories/authentication_repository.dart';
import '../features/authentication/domain/usecases/check_user_usecase.dart';
import '../features/authentication/domain/usecases/delete_all_data_usecase.dart';
import '../features/authentication/domain/usecases/delete_user_usecase.dart';
import '../features/authentication/domain/usecases/get_installation_status_usecase.dart';
import '../features/authentication/domain/usecases/get_introduction_status.dart';
import '../features/authentication/domain/usecases/get_user_usecase.dart';
import '../features/authentication/domain/usecases/save_user_usecase.dart';
import '../features/authentication/domain/usecases/update_installation_status_usecase.dart';
import '../features/authentication/domain/usecases/update_introduction_status_usecase.dart';
import '../features/overtime/data/datasources/overtime_api_services.dart';
import '../features/overtime/data/repositories/overtime_repository_impl.dart';
import '../features/overtime/domain/repositories/overtime_repository.dart';
import '../features/overtime/domain/usecases/get_overtime_detail_usecase.dart';
import '../features/overtime/domain/usecases/get_overtime_list_usecase.dart';
import '../features/reprimand/domain/usecases/get_reprimand_approval_list_usecase.dart';
import '../features/sign_in/data/datasources/sign_in_datasource.dart';
import '../features/sign_in/data/repositories/sign_in_repository_impl.dart';
import '../features/sign_in/domain/repositories/sign_in_repository.dart';
import '../features/sign_in/domain/usecases/staff_sign_in_usecase.dart';
import 'shared_prefs_services.dart';
import 'storage.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //shared prefs manager
  injector.registerSingleton<SharedPreferencesServices>(
    SharedPreferencesServices(),
  );

  // Dio client
  injector.registerSingleton<Dio>(getDio());

  // Secure storage
  injector.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );

  injector.registerSingleton<SecureStorage>(
    SecureStorage(flutterSecureStorage: injector()),
  );

  // API
  injector.registerSingleton<SignInApiServices>(
    SignInApiServices(
      injector(),
      baseUrl: 'http://103.53.1.163:8080/restapi/user',
    ),
  );

  injector.registerSingleton<HomeApiServices>(
    HomeApiServices(
      injector(),
    ),
  );

  injector.registerSingleton<LeaveApiServices>(
    LeaveApiServices(
      injector(),
    ),
  );

  injector.registerSingleton<BusinessTripApiServices>(
    BusinessTripApiServices(
      injector(),
    ),
  );

  injector.registerSingleton<OvertimeApiServices>(
    OvertimeApiServices(
      injector(),
    ),
  );

  injector.registerSingleton<DispensationApiServices>(
    DispensationApiServices(
      injector(),
    ),
  );

  injector.registerSingleton<ReprimandApiServices>(
    ReprimandApiServices(
      injector(),
    ),
  );

  injector.registerSingleton<SwapWorkdateApiServices>(
    SwapWorkdateApiServices(
      injector(),
    ),
  );

  injector.registerSingleton<AttendanceApiServices>(
    AttendanceApiServices(
      injector(),
    ),
  );

  injector.registerSingleton<ApprovalsApiServices>(
    ApprovalsApiServices(
      injector(),
    ),
  );

  //Repositories
  injector.registerSingleton<SignInRepository>(
    SignInRepositoryImpl(signInApiServices: injector()),
  );

  injector.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      secureStorage: injector(),
      sharedPreferencesServices: injector(),
    ),
  );

  injector.registerSingleton<HomeRepository>(
    HomeRepositoryImpl(
      homeApiServices: injector(),
      secureStorage: injector(),
    ),
  );

  injector.registerSingleton<LeaveRepository>(
    LeaveRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  injector.registerSingleton<BusinessTripRepository>(
    BusinessTripRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  injector.registerSingleton<OvertimeRepository>(
    OvertimeRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  injector.registerSingleton<DispensationRepository>(
    DispensationRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  injector.registerSingleton<ReprimandRepository>(
    ReprimandRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  injector.registerSingleton<SwapWorkdateRepository>(
    SwapWorkdateRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  injector.registerSingleton<AttendanceRepository>(
    AttendanceRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  injector.registerSingleton<ApprovalsRepository>(
    ApprovalsRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  /*** General Usecases ***/
  injector.registerSingleton<StaffSignInUseCase>(
    StaffSignInUseCase(injector()),
  );

  injector.registerSingleton<CheckUserUsecase>(
    CheckUserUsecase(authenticationRepository: injector()),
  );

  injector.registerSingleton<DeleteUserUsecase>(
    DeleteUserUsecase(authenticationRepository: injector()),
  );

  injector.registerSingleton<GetUserUsecase>(
    GetUserUsecase(authenticationRepository: injector()),
  );

  injector.registerSingleton<SaveUserUsecase>(
    SaveUserUsecase(authenticationRepository: injector()),
  );

  injector.registerSingleton<GetIntroductionScreenStatusUsecase>(
    GetIntroductionScreenStatusUsecase(authenticationRepository: injector()),
  );

  injector.registerSingleton<UpdateIntroductionScreenStatusUsecase>(
    UpdateIntroductionScreenStatusUsecase(authenticationRepository: injector()),
  );

  injector.registerSingleton<UpdateInstallationStatusUsecase>(
    UpdateInstallationStatusUsecase(authenticationRepository: injector()),
  );

  injector.registerSingleton<GetInstallationStatusUsecase>(
    GetInstallationStatusUsecase(authenticationRepository: injector()),
  );

  injector.registerSingleton<DeleteAllDataUsecase>(
    DeleteAllDataUsecase(authenticationRepository: injector()),
  );

  /*** Home Usecases ***/
  injector.registerSingleton<GetEmployeeAttendanceSummary>(
    GetEmployeeAttendanceSummary(injector()),
  );

  injector.registerSingleton<GetEmployeeBirthday>(
    GetEmployeeBirthday(injector()),
  );

  injector.registerSingleton<GetEmployeePenaltySummary>(
    GetEmployeePenaltySummary(injector()),
  );

  /*** Leave Usecases ***/
  injector.registerSingleton<GetLeaveListUsecase>(
    GetLeaveListUsecase(injector()),
  );

  injector.registerSingleton<GetLeaveDetailUsecase>(
    GetLeaveDetailUsecase(injector()),
  );

  injector.registerSingleton<GetLeaveTypesUsecase>(
    GetLeaveTypesUsecase(injector()),
  );

  injector.registerSingleton<GetLeaveApprovalHistoryListUsecase>(
    GetLeaveApprovalHistoryListUsecase(injector()),
  );

  injector.registerSingleton<GetLeaveApprovalListUsecase>(
    GetLeaveApprovalListUsecase(injector()),
  );

  injector.registerSingleton<PatchLeaveStatusUsecase>(
    PatchLeaveStatusUsecase(injector()),
  );

  injector.registerSingleton<ApproveLeaveRequestUsecase>(
    ApproveLeaveRequestUsecase(injector()),
  );

  injector.registerSingleton<RejectLeaveRequestUsecase>(
    RejectLeaveRequestUsecase(injector()),
  );

  /*** Business Trip Usecases ***/
  injector.registerSingleton<GetBusinessTripListUsecase>(
    GetBusinessTripListUsecase(injector()),
  );

  injector.registerSingleton<GetBusinessTripDetailUsecase>(
    GetBusinessTripDetailUsecase(injector()),
  );

  injector.registerSingleton<GetBusinessTripApprovalListUsecase>(
    GetBusinessTripApprovalListUsecase(injector()),
  );

  injector.registerSingleton<GetBusinessTripApprovalHistoryListUsecase>(
    GetBusinessTripApprovalHistoryListUsecase(injector()),
  );

  /*** Overtime Usecases ***/
  injector.registerSingleton<GetOvertimeListUsecase>(
    GetOvertimeListUsecase(injector()),
  );

  injector.registerSingleton<GetOvertimeApprovalListUsecase>(
    GetOvertimeApprovalListUsecase(injector()),
  );

  injector.registerSingleton<GetOvertimeDetailUsecase>(
    GetOvertimeDetailUsecase(injector()),
  );

  injector.registerSingleton<GetOvertimeApprovalHistoryListUsecase>(
    GetOvertimeApprovalHistoryListUsecase(injector()),
  );

  /*** Dispensation Usecases ***/
  injector.registerSingleton<GetDispensationListUsecase>(
    GetDispensationListUsecase(injector()),
  );

  injector.registerSingleton<GetDispensationApprovalListUsecase>(
    GetDispensationApprovalListUsecase(injector()),
  );

  injector.registerSingleton<GetDispensationDetailUsecase>(
    GetDispensationDetailUsecase(injector()),
  );

  injector.registerSingleton<GetDispensationApprovalHistoryListUsecase>(
    GetDispensationApprovalHistoryListUsecase(injector()),
  );

  /*** Reprimand Usecases ***/
  injector.registerSingleton<GetReprimandListUsecase>(
    GetReprimandListUsecase(injector()),
  );

  injector.registerSingleton<GetReprimandApprovalListUsecase>(
    GetReprimandApprovalListUsecase(injector()),
  );

  injector.registerSingleton<GetReprimandDetailUsecase>(
    GetReprimandDetailUsecase(injector()),
  );

  injector.registerSingleton<GetReprimandApprovalHistoryListUsecase>(
    GetReprimandApprovalHistoryListUsecase(injector()),
  );

  /*** Swap workdate Usecases ***/
  injector.registerSingleton<GetSwapWorkdateListUsecase>(
    GetSwapWorkdateListUsecase(injector()),
  );

  injector.registerSingleton<GetSwapWorkdateApprovalListUsecase>(
    GetSwapWorkdateApprovalListUsecase(injector()),
  );

  injector.registerSingleton<GetSwapWorkdateApprovalHistoryListUsecase>(
    GetSwapWorkdateApprovalHistoryListUsecase(injector()),
  );

  injector.registerSingleton<GetSwapWorkdateDetailUsecase>(
    GetSwapWorkdateDetailUsecase(injector()),
  );

  /*** Attendance Usecases ***/
  injector.registerSingleton<GetAttendanceDetailUsecase>(
    GetAttendanceDetailUsecase(injector()),
  );

  injector.registerSingleton<GetAttendanceListUsecase>(
    GetAttendanceListUsecase(injector()),
  );

  injector.registerSingleton<GetAttendanceApprovalListUsecase>(
    GetAttendanceApprovalListUsecase(injector()),
  );

  injector.registerSingleton<GetAttendanceApprovalHistoryListUsecase>(
    GetAttendanceApprovalHistoryListUsecase(injector()),
  );

  /*** Approvals Usecases ***/
  injector.registerSingleton<GetApprovalsCountUsecase>(
    GetApprovalsCountUsecase(injector()),
  );
}
