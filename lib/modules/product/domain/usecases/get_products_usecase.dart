import 'package:dartz/dartz.dart';

import '../entities/product_entity.dart';
import '../exception/product_exception.dart';
import '../repositories/product_repository.dart';

abstract class GetProductsUseCase {
  Future<Either<ProductException, List<ProductEntity>>> call();
}

class GetProductsUseCaseImpl implements GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCaseImpl({required ProductRepository repository}) : _repository = repository;

  @override
  Future<Either<ProductException, List<ProductEntity>>> call() => _repository.getProducts();
}
