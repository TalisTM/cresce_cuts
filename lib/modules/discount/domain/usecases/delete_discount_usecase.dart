import 'package:dartz/dartz.dart';

import '../entities/discount_entity.dart';
import '../exception/discount_exception.dart';
import '../repositories/discount_repository.dart';

abstract class DeleteDiscountUseCase {
  Future<Either<DiscountException, Unit>> call({required DiscountEntity discount});
}

class DeleteDiscountUseCaseImpl implements DeleteDiscountUseCase {
  final DiscountRepository _repository;

  DeleteDiscountUseCaseImpl({required DiscountRepository repository}) : _repository = repository;

  @override
  Future<Either<DiscountException, Unit>> call({required DiscountEntity discount}) =>
      _repository.deleteDiscount(discount: discount);
}
