import 'package:cresce_cuts/core/contants/enums.dart';
import 'package:cresce_cuts/modules/product/domain/entities/product_entity.dart';
import 'package:cresce_cuts/modules/product/domain/exception/product_exception.dart';
import 'package:cresce_cuts/modules/product/domain/usecases/get_products_usecase.dart';
import 'package:cresce_cuts/modules/product/presentation/product/product_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../product_mocks.dart';

void main() {
  late GetProductsUseCase getProductsUseCase;
  late ProductController productController;

  setUp(() {
    getProductsUseCase = GetProductsUseCaseMock();
    productController = ProductController(getProductsUseCase: getProductsUseCase);
  });

  group('ProductController', () {
    group('getProducts', () {
      test('Deve buscar uma lista de produtos', () async {
        when(() => getProductsUseCase()).thenAnswer((_) async => const Right(productsMock));

        expect(productController.products, const <ProductEntity>[]);
        expect(productController.status, Status.intial);

        await productController.getProducts();

        expect(productController.products, productsMock);
        expect(productController.status, Status.success);
      });

      test('Deve retornar um erro ao buscar a lista de produtos', () async {
        when(() => getProductsUseCase()).thenAnswer((_) async => Left(ProductError()));

        expect(productController.products, const <ProductEntity>[]);
        expect(productController.status, Status.intial);

        await productController.getProducts();

        expect(productController.products, const <ProductEntity>[]);
        expect(productController.status, Status.error);
      });
    });
  });
}
