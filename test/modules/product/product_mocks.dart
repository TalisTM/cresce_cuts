import 'package:cresce_cuts/modules/product/data/datasources/product_datasource.dart';
import 'package:cresce_cuts/modules/product/domain/entities/product_entity.dart';
import 'package:cresce_cuts/modules/product/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

class ProductDatasourceMock extends Mock implements ProductDatasource {}

class ProductRepositoryMock extends Mock implements ProductRepository {}

const productsMapMock = <Map<String, dynamic>>[
  {
    'id': 1,
    'title': 'title',
    'price': 'price',
    'category': 'category',
    'description': 'description',
    'image': 'image'
  },
  {
    'id': 2,
    'title': 'title',
    'price': 'price',
    'category': 'category',
    'description': 'description',
    'image': 'image'
  }
];

const productsMock = [
  ProductEntity(
    id: 1,
    title: 'title',
    price: 'price',
    category: 'category',
    description: 'description',
    image: 'image',
  ),
  ProductEntity(
    id: 2,
    title: 'title',
    price: 'price',
    category: 'category',
    description: 'description',
    image: 'image',
  ),
];

final responseMock = Response(requestOptions: RequestOptions(), data: productsMapMock);