import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/usecases/delete_all_data_usecase.dart';
import '../domain/usecases/delete_user_usecase.dart';
import '../domain/usecases/get_installation_status_usecase.dart';
import '../domain/usecases/get_introduction_status.dart';
import '../domain/usecases/get_user_usecase.dart';
import '../domain/usecases/save_user_usecase.dart';
import '../domain/usecases/update_installation_status_usecase.dart';
import '../domain/usecases/update_introduction_status_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.getUser,
    required this.deleteUser,
    required this.deleteAllData,
    required this.saveUser,
    required this.saveIntroductionScreenStatus,
    required this.getIntroductionScreenStatus,
    required this.getInstallationStatus,
    required this.updateInstallationStatus,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationLogin>(_onLoginUser);
    on<AuthenticationLogoutRequested>(_onLogoutUser);
    on<AppStarted>(_onAppStarted);
    on<SaveIntroductionState>(_onSaveIntroductionState);
  }

  final GetUserUsecase getUser;
  final SaveUserUsecase saveUser;
  final DeleteUserUsecase deleteUser;
  final DeleteAllDataUsecase deleteAllData;
  final UpdateIntroductionScreenStatusUsecase saveIntroductionScreenStatus;
  final GetIntroductionScreenStatusUsecase getIntroductionScreenStatus;
  final GetInstallationStatusUsecase getInstallationStatus;
  final UpdateInstallationStatusUsecase updateInstallationStatus;

  void _onLoginUser(
    AuthenticationLogin event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      var userString = event.user;
      await saveUser.call(userString);
      emit(AuthenticationComplete(userString));
    } catch (e) {
      emit(AuthenticationFailure());
      emit(const AuthenticationUnauthenticated(introductionStatus: true));
    }
  }

  void _onLogoutUser(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    // emit(AuthenticationLoading());
    try {
      await deleteUser.call();
      emit(const AuthenticationUnauthenticated(introductionStatus: true));
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }

  void _onSaveIntroductionState(
    SaveIntroductionState event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await saveIntroductionScreenStatus.call(event.isSeen);
    } catch (e) {
      // emit(AuthenticationFailure());
    }
  }

  void _onAppStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    // emit(AuthenticationLoading());
    bool isSeen = false;

    final introductionScreenStatus = await getIntroductionScreenStatus.call();

    final installationStatus = await getInstallationStatus.call();

    installationStatus.fold(
      (l) {
        deleteAllData();
      },
      (r) {
        if (r == null) {
          updateInstallationStatus(isFreshInstall: true);
          deleteAllData();
          updateInstallationStatus(isFreshInstall: false);
        }
      },
    );

    introductionScreenStatus!.fold(
      (l) {
        isSeen = false;
      },
      (r) {
        isSeen = r!;
      },
    );

    try {
      final user = await getUser.call();
      user.fold(
        (l) {
          emit(AuthenticationFailure());
          emit(AuthenticationUnauthenticated(introductionStatus: isSeen));
        },
        (r) {
          var userString = r;
          emit(AuthenticationComplete(userString));
        },
      );
    } catch (e) {
      emit(AuthenticationUnauthenticated(introductionStatus: isSeen));
    }
  }
}
