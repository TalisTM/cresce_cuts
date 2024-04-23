
import 'package:dartz/dartz.dart';

import '../entities/discount_entity.dart';
import '../exception/discount_exception.dart';
import '../repositories/discount_repository.dart';

abstract class UpdateDiscountUseCase {
  Future<Either<DiscountException, Unit>> call({required DiscountEntity discount});
}

class UpdateDiscountUseCaseImpl implements UpdateDiscountUseCase {
  final DiscountRepository _repository;

  UpdateDiscountUseCaseImpl({required DiscountRepository repository}) : _repository = repository;

  @override
  Future<Either<DiscountException, Unit>> call({required DiscountEntity discount}) =>
      _repository.updateDiscount(discount: discount);
}
