import 'package:dartz/dartz.dart';

import '../entities/discount_entity.dart';
import '../exception/discount_exception.dart';
import '../repositories/discount_repository.dart';

abstract class CreateDiscountUseCase {
  Future<Either<DiscountException, Unit>> call({required DiscountEntity discount});
}

class CreateDiscountUseCaseImpl implements CreateDiscountUseCase {
  final DiscountRepository _repository;

 CreateDiscountUseCaseImpl({required DiscountRepository repository}) : _repository = repository;

  @override
  Future<Either<DiscountException, Unit>> call({required DiscountEntity discount}) => _repository.createDiscount(discount: discount);
}
