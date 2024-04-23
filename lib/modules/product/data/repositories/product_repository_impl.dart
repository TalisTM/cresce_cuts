import 'package:dartz/dartz.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/exception/product_exception.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource _datasource;

  ProductRepositoryImpl({required ProductDatasource datasource}) : _datasource = datasource;

  @override
  Future<Either<ProductException, List<ProductEntity>>> getProducts() async {
    try {
      var result = await _datasource.getProducts();
      return Right(result);
    } on ProductException catch (e) {
      return Left(e);
    }
  }
}
