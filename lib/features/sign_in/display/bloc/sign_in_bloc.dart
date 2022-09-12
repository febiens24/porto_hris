import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/bloc/authentication_bloc.dart';
import '../../domain/entities/user_error_entity.dart';
import '../../domain/usecases/staff_sign_in_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationBloc authenticationBloc;
  final StaffSignInUseCase staffSignInUseCase;

  SignInBloc({
    required this.authenticationBloc,
    required this.staffSignInUseCase,
  }) : super(SignInInitial()) {
    on<SignInUser>(_onSignInUser);
  }

  void _onSignInUser(SignInUser event, Emitter<SignInState> emit) async {
    emit(SignInLoading());
    try {
      // final userRes = await staffSignInUseCase.call(
      //   event.username,
      //   event.password,
      // );
      // userRes.fold(
      //   (l) {
      //     emit(SignInFailure(l));
      //   },
      //   (r) {
      //     String userId = r.result!.userId;
      //     emit(SignInComplete(userId));
      //   },
      // );
      emit(const SignInComplete('userId'));
    } catch (e) {
      emit(
        SignInFailure(
          UserErrorEntity(
            status: 'error',
            result: e.toString(),
          ),
        ),
      );
    }
  }
}
