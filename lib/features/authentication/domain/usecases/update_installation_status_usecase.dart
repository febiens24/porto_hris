import '../repositories/authentication_repository.dart';

class UpdateInstallationStatusUsecase {
  final AuthenticationRepository authenticationRepository;

  const UpdateInstallationStatusUsecase({
    required this.authenticationRepository,
  });

  Future<void> call({required bool isFreshInstall}) async {
    return authenticationRepository.updateInstallationStatus(isFreshInstall);
  }
}
