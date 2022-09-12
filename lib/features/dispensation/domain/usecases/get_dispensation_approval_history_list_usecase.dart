import 'package:dartz/dartz.dart';

import '../entities/dispensation_entity.dart';
import '../repositories/dispensation_repository.dart';

class GetDispensationApprovalHistoryListUsecase {
  final DispensationRepository dispensationRepository;

  GetDispensationApprovalHistoryListUsecase(this.dispensationRepository);

  Future<Either<Map<String, dynamic>, DispensationEntity>> call({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    return await dispensationRepository.getDispensationApprovalHistoryList(
      status: status,
      type: type,
      dateFrom: dateFrom,
      dateTo: dateTo,
      q: q,
      page: page,
    );
  }
}
