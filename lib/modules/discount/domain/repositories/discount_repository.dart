import 'package:dartz/dartz.dart';

import '../entities/discount_entity.dart';
import '../exception/discount_exception.dart';

abstract class DiscountRepository {
  Future<Either<DiscountException, List<DiscountEntity>>> getDiscounts();
  Future<Either<DiscountException, Unit>> createDiscount({required DiscountEntity discount});
  Future<Either<DiscountException, Unit>> updateDiscount({required DiscountEntity discount});
  Future<Either<DiscountException, Unit>> deleteDiscount({required DiscountEntity discount});
}
