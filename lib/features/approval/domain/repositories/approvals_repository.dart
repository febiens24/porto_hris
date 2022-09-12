import 'package:dartz/dartz.dart';

import '../entities/approvals_entity.dart';

abstract class ApprovalsRepository {
  Future<Either<Map<String, dynamic>, ApprovalsEntity>> getApprovalsCount();
}
