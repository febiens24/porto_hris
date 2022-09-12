import 'package:dartz/dartz.dart';

import '../entities/dispensation_entity.dart';
import '../repositories/dispensation_repository.dart';

class GetDispensationApprovalListUsecase {
  final DispensationRepository dispensationRepository;

  GetDispensationApprovalListUsecase(this.dispensationRepository);

  Future<Either<Map<String, dynamic>, DispensationEntity>> call() async {
    return await dispensationRepository.getDispensationApprovalList();
  }
}
