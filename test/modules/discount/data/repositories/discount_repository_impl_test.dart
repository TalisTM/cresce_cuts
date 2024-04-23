import 'package:cresce_cuts/modules/discount/data/datasources/discount_datasource.dart';
import 'package:cresce_cuts/modules/discount/data/repositories/discount_repository_impl.dart';
import 'package:cresce_cuts/modules/discount/domain/exception/discount_exception.dart';
import 'package:cresce_cuts/modules/discount/domain/repositories/discount_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../discount_mocks.dart';

main() {
  late DiscountDatasource datasource;
  late DiscountRepository repository;

  setUp(() {
    registerFallbackValue(discountMock);
    datasource = DiscountDatasourceMock();
    repository = DiscountRepositoryImpl(datasource: datasource);
  });

  group('DiscountRepository', () {
    group('getDiscounts', () {
      test('Deve retornar uma lista de discounts', () async {
        when(() => datasource.getDiscounts()).thenAnswer((_) async => discountsMock);

        final result = await repository.getDiscounts();

        expect(result, Right(discountsMock));

        verify(() => datasource.getDiscounts()).called(1);
      });

      test('Deve retornar um erro', () async {
        when(() => datasource.getDiscounts()).thenThrow(DiscountError());

        final result = await repository.getDiscounts();

        expect(result.fold(id, id), isA<DiscountException>());

        verify(() => datasource.getDiscounts()).called(1);
      });
    });

    group('createDiscount', () {
      test('Deve salvar o desconto criado', () async {
        when(() => datasource.createDiscount(discount: any(named: 'discount')))
            .thenAnswer((_) async {});

        final result = await repository.createDiscount(discount: discountMock);

        expect(result, const Right(unit));

        verify(() => datasource.createDiscount(discount: any(named: 'discount'))).called(1);
      });

      test('Deve retornar um erro', () async {
        when(() => datasource.createDiscount(discount: any(named: 'discount')))
            .thenThrow(DiscountError());

        final result = await repository.createDiscount(discount: discountMock);

        expect(result.fold(id, id), isA<DiscountException>());

        verify(() => datasource.createDiscount(discount: any(named: 'discount'))).called(1);
      });
    });

    group('updateDiscount', () {
      test('Deve salvar o desconto atualizado', () async {
        when(() => datasource.updateDiscount(discount: any(named: 'discount')))
            .thenAnswer((_) async {});

        final result = await repository.updateDiscount(discount: discountMock);

        expect(result, const Right(unit));

        verify(() => datasource.updateDiscount(discount: any(named: 'discount'))).called(1);
      });

      test('Deve retornar um erro', () async {
        when(() => datasource.updateDiscount(discount: any(named: 'discount')))
            .thenThrow(DiscountError());

        final result = await repository.updateDiscount(discount: discountMock);

        expect(result.fold(id, id), isA<DiscountException>());

        verify(() => datasource.updateDiscount(discount: any(named: 'discount'))).called(1);
      });
    });

    group('deleteDiscount', () {
      test('Deve salvar o desconto atualizado', () async {
        when(() => datasource.deleteDiscount(discount: any(named: 'discount')))
            .thenAnswer((_) async {});

        final result = await repository.deleteDiscount(discount: discountMock);

        expect(result, const Right(unit));

        verify(() => datasource.deleteDiscount(discount: any(named: 'discount'))).called(1);
      });

      test('Deve retornar um erro', () async {
        when(() => datasource.deleteDiscount(discount: any(named: 'discount')))
            .thenThrow(DiscountError());

        final result = await repository.deleteDiscount(discount: discountMock);

        expect(result.fold(id, id), isA<DiscountException>());

        verify(() => datasource.deleteDiscount(discount: any(named: 'discount'))).called(1);
      });
    });
  });
}
