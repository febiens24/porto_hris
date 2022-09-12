import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../entities/user_error_entity.dart';

abstract class SignInRepository {
  Future<Either<UserErrorEntity, UserEntity>> staffSignIn(
    String username,
    String password,
  );
}
