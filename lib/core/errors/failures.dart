abstract class Failure {
  final String? errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required String? errorMessage})
      : super(errorMessage: errorMessage);
}

class StorageFailure extends Failure {
  StorageFailure({required String? errorMessage})
      : super(errorMessage: errorMessage);
}
