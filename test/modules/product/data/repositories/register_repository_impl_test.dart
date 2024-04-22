import 'package:cresce_cuts/modules/product/data/datasources/product_datasource.dart';
import 'package:cresce_cuts/modules/product/data/repositories/register_repository_impl.dart';
import 'package:cresce_cuts/modules/product/domain/entities/product_entity.dart';
import 'package:cresce_cuts/modules/product/domain/exception/product_exception.dart';
import 'package:cresce_cuts/modules/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../product_mocks.dart';

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

main() {
  late ProductDatasource datasource;
  late ProductRepository repository;

  setUp(() {
    datasource = ProductDatasourceMock();
    repository = ProductRepositoryImpl(datasource: datasource);
  });

  group('ProductRepository', () {
    group('getProducts', () {
      test('Deve retornar [true] para a validação do mnemonic', () async {
        when(() => datasource.getProducts()).thenAnswer((_) async => productsMock);

        final result = await repository.getProducts();

        expect(result, const Right(productsMock));

        verify(() => datasource.getProducts()).called(1);
      });

      test('Deve retornar um erro', () async {
        when(() => datasource.getProducts()).thenThrow(ProductError());

        final result = await repository.getProducts();

        expect(result.fold(id, id), isA<ProductException>());

        verify(() => datasource.getProducts()).called(1);
      });
    });
  });
}
