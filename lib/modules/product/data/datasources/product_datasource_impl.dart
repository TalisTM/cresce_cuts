import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../core/contants/endpoints.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/exception/product_exception.dart';
import '../models/product_mapper.dart';
import 'product_datasource.dart';

class ProductDatasourceImpl implements ProductDatasource {
  final Dio _dio;
  ProductDatasourceImpl({required Dio dio}) : _dio = dio;

  Never _genericError(Object e, StackTrace s) {
    throw ProductError();
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      final response = await _dio.get(Endpoints.getProducts);

      final products = response.data!
          .map<ProductEntity>((productMap) => ProductMapper.fromMap(productMap))
          .toList();
      return products;
    } catch (e, s) {
      _genericError(e, s);
    }
  }
}
