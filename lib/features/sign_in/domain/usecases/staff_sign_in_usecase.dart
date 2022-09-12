import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../entities/user_error_entity.dart';
import '../repositories/sign_in_repository.dart';

class StaffSignInUseCase {
  final SignInRepository _signInRepository;
  const StaffSignInUseCase(this._signInRepository);

  Future<Either<UserErrorEntity, UserEntity>> call(
    String username,
    String password,
  ) async {
    return await _signInRepository.staffSignIn(
      username,
      password,
    );
  }
}
