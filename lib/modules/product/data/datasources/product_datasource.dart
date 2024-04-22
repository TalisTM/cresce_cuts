import '../../domain/entities/product_entity.dart';

abstract class ProductDatasource {
  Future<List<ProductEntity>> getProducts();
}
