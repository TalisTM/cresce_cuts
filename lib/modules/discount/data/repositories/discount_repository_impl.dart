import 'package:dartz/dartz.dart';

import '../../domain/entities/discount_entity.dart';
import '../../domain/exception/discount_exception.dart';
import '../../domain/repositories/discount_repository.dart';
import '../datasources/discount_datasource.dart';

class DiscountRepositoryImpl implements DiscountRepository {
  final DiscountDatasource _datasource;

  DiscountRepositoryImpl({required DiscountDatasource datasource}) : _datasource = datasource;

  @override
  Future<Either<DiscountException, List<DiscountEntity>>> getDiscounts() async {
    try {
      var result = await _datasource.getDiscounts();
      return Right(result);
    } on DiscountException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DiscountException, Unit>> createDiscount({required DiscountEntity discount}) async {
    try {
      await _datasource.createDiscount(discount: discount);
      return const Right(unit);
    } on DiscountException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DiscountException, Unit>> updateDiscount({required DiscountEntity discount}) async {
    try {
      await _datasource.updateDiscount(discount: discount);
      return const Right(unit);
    } on DiscountException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DiscountException, Unit>> deleteDiscount({required DiscountEntity discount}) async {
    try {
      await _datasource.deleteDiscount(discount: discount);
      return const Right(unit);
    } on DiscountException catch (e) {
      return Left(e);
    }
  }
}
