import 'package:cresce_cuts/modules/product/data/datasources/product_datasource.dart';
import 'package:cresce_cuts/modules/product/domain/entities/product_entity.dart';
import 'package:cresce_cuts/modules/product/domain/repositories/product_repository.dart';
import 'package:cresce_cuts/modules/product/domain/usecases/get_products_usecase.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

class ProductDatasourceMock extends Mock implements ProductDatasource {}

class ProductRepositoryMock extends Mock implements ProductRepository {}

class GetProductsUseCaseMock extends Mock implements GetProductsUseCase {}

const productsMapMock = <Map<String, dynamic>>[
  {
    'id': 1,
    'title': 'title',
    'price': 10.0,
    'category': 'category',
    'description': 'description',
    'image': 'image'
  },
  {
    'id': 2,
    'title': 'title',
    'price': 20.0,
    'category': 'category',
    'description': 'description',
    'image': 'image'
  }
];

const productsMock = [
  ProductEntity(
    id: 1,
    title: 'title',
    price: 10.0,
    category: 'category',
    description: 'description',
    image: 'image',
  ),
  ProductEntity(
    id: 2,
    title: 'title',
    price: 20.0,
    category: 'category',
    description: 'description',
    image: 'image',
  ),
];

final responseMock = Response(requestOptions: RequestOptions(), data: productsMapMock);