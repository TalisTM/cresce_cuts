import 'package:dartz/dartz.dart';

import '../entities/product_entity.dart';
import '../exception/product_exception.dart';

abstract class ProductRepository {
  Future<Either<ProductException, List<ProductEntity>>> getProducts();
}
