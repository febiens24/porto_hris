import '../repositories/authentication_repository.dart';

class UpdateIntroductionScreenStatusUsecase {
  final AuthenticationRepository authenticationRepository;

  const UpdateIntroductionScreenStatusUsecase(
      {required this.authenticationRepository});

  Future<void> call(bool isSeen) async {
    return authenticationRepository.saveIntroductionStatus(isSeen);
  }
}
