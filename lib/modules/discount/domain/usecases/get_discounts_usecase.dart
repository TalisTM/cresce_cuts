import 'package:dartz/dartz.dart';

import '../entities/discount_entity.dart';
import '../exception/discount_exception.dart';
import '../repositories/discount_repository.dart';

abstract class GetDiscountsUseCase {
  Future<Either<DiscountException, List<DiscountEntity>>> call();
}

class GetDiscountsUseCaseImpl implements GetDiscountsUseCase {
  final DiscountRepository _repository;

  GetDiscountsUseCaseImpl({required DiscountRepository repository}) : _repository = repository;

  @override
  Future<Either<DiscountException, List<DiscountEntity>>> call() => _repository.getDiscounts();
}
