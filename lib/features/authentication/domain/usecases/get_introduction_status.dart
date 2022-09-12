import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/authentication_repository.dart';

class GetIntroductionScreenStatusUsecase {
  final AuthenticationRepository authenticationRepository;

  const GetIntroductionScreenStatusUsecase(
      {required this.authenticationRepository});

  Future<Either<Failure, bool?>?> call() async {
    return await authenticationRepository.getIntroductionScreenStatus();
  }
}
