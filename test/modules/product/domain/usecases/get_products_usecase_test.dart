import 'package:cresce_cuts/modules/product/domain/exception/product_exception.dart';
import 'package:cresce_cuts/modules/product/domain/repositories/product_repository.dart';
import 'package:cresce_cuts/modules/product/domain/usecases/get_products_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../product_mocks.dart';

void main() {
  late ProductRepository repository;
  late GetProductsUseCase useCase;

  setUp(() {
    repository = ProductRepositoryMock();
    useCase = GetProductsUseCaseImpl(repository: repository);
  });

  group('GetProductsUseCase', () {
    test('Deve retornar uma lista de produtos', () async {
      when(() => repository.getProducts()).thenAnswer((_) async => const Right(productsMock));

      final result = await useCase();

      verify(() => repository.getProducts()).called(1);
      expect(result, const Right(productsMock));
    });

    test('Deve retornar um erro', () async {
      when(() => repository.getProducts()).thenAnswer((_) async => Left(ProductError()));

      final result = await useCase();

      verify(() => repository.getProducts()).called(1);
      expect(result.fold(id, id), isA<ProductError>());
    });
  });
}
