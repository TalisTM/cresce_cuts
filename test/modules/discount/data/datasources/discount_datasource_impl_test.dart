import 'package:cresce_cuts/core/services/local_storage/local_storage.dart';
import 'package:cresce_cuts/modules/discount/data/datasources/discount_datasource.dart';
import 'package:cresce_cuts/modules/discount/data/datasources/discount_datasource_impl.dart';
import 'package:cresce_cuts/modules/discount/domain/exception/discount_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../discount_mocks.dart';

main() {
  late LocalStorage localStorage;
  late DiscountDatasource datasource;

  setUp(() {
    localStorage = LocalStorageMock();
    datasource = DiscountDatasourceImpl(localStorage: localStorage);
  });

  group('DiscountDatasource', () {
    group('getDiscounts', () {
      test('Deve retornar uma lista de descontos', () async {
        when(() => localStorage.read<List<String>>(any()))
            .thenAnswer((_) async => discountsJsonMock);

        final result = await datasource.getDiscounts();

        expect(result, discountsMock);

        verify(() => localStorage.read<List<String>>(any())).called(1);
      });

      test('deve retornar um erro', () {
        when(() => localStorage.read<List<String>>(any())).thenThrow(Exception());

        final result = datasource.getDiscounts();

        expect(result, throwsA(isA<DiscountError>()));

        verify(() => localStorage.read<List<String>>(any())).called(1);
      });
    });

    group('createDiscount', () {
      test('Deve salvar o desconto criado', () async {
        when(() => localStorage.read<List<String>>(any()))
            .thenAnswer((_) async => discountsJsonMock);
        when(() => localStorage.write<List<String>>(any(), any())).thenAnswer((_) async {});

        final result = datasource.createDiscount(discount: discountMock);

        await expectLater(result, completes);

        verify(() => localStorage.read<List<String>>(any())).called(1);
        verify(() => localStorage.write<List<String>>(any(), any())).called(1);
      });

      test('deve retornar um erro no localStorage.read', () {
        when(() => localStorage.read<List<String>>(any())).thenThrow(Exception());

        final result = datasource.createDiscount(discount: discountMock);

        expect(result, throwsA(isA<DiscountError>()));

        verify(() => localStorage.read<List<String>>(any())).called(1);
        verifyNever(() => localStorage.write<List<String>>(any(), any()));
      });

      test('deve retornar um erro no localStorage.write', () async {
        when(() => localStorage.read<List<String>>(any()))
            .thenAnswer((_) async => discountsJsonMock);
        when(() => localStorage.write<List<String>>(any(), any())).thenThrow(Exception());

        final result = datasource.createDiscount(discount: discountMock);

        await expectLater(result, throwsA(isA<DiscountError>()));

        verify(() => localStorage.read<List<String>>(any())).called(1);
        verify(() => localStorage.write<List<String>>(any(), any())).called(1);
      });
    });

    group('updateDiscount', () {
      test('Deve salvar o desconto criado', () async {
        when(() => localStorage.read<List<String>>(any()))
            .thenAnswer((_) async => discountsJsonMock);
        when(() => localStorage.write<List<String>>(any(), any())).thenAnswer((_) async {});

        final result = datasource.updateDiscount(discount: discountMock);

        await expectLater(result, completes);

        verify(() => localStorage.read<List<String>>(any())).called(1);
        verify(() => localStorage.write<List<String>>(any(), any())).called(1);
      });

      test('deve retornar um erro no localStorage.read', () {
        when(() => localStorage.read<List<String>>(any())).thenThrow(Exception());

        final result = datasource.updateDiscount(discount: discountMock);

        expect(result, throwsA(isA<DiscountError>()));

        verify(() => localStorage.read<List<String>>(any())).called(1);
        verifyNever(() => localStorage.write<List<String>>(any(), any()));
      });

      test('deve retornar um erro no localStorage.write', () async {
        when(() => localStorage.read<List<String>>(any()))
            .thenAnswer((_) async => discountsJsonMock);
        when(() => localStorage.write<List<String>>(any(), any())).thenThrow(Exception());

        final result = datasource.updateDiscount(discount: discountMock);

        await expectLater(result, throwsA(isA<DiscountError>()));

        verify(() => localStorage.read<List<String>>(any())).called(1);
        verify(() => localStorage.write<List<String>>(any(), any())).called(1);
      });
    });

    group('deleteDiscount', () {
      test('Deve salvar o desconto criado', () async {
        when(() => localStorage.read<List<String>>(any()))
            .thenAnswer((_) async => discountsJsonMock);
        when(() => localStorage.write<List<String>>(any(), any())).thenAnswer((_) async {});

        final result = datasource.deleteDiscount(discount: discountMock);

        await expectLater(result, completes);

        verify(() => localStorage.read<List<String>>(any())).called(1);
        verify(() => localStorage.write<List<String>>(any(), any())).called(1);
      });

      test('deve retornar um erro no localStorage.read', () {
        when(() => localStorage.read<List<String>>(any())).thenThrow(Exception());

        final result = datasource.deleteDiscount(discount: discountMock);

        expect(result, throwsA(isA<DiscountError>()));

        verify(() => localStorage.read<List<String>>(any())).called(1);
        verifyNever(() => localStorage.write<List<String>>(any(), any()));
      });

      test('deve retornar um erro no localStorage.write', () async {
        when(() => localStorage.read<List<String>>(any()))
            .thenAnswer((_) async => discountsJsonMock);
        when(() => localStorage.write<List<String>>(any(), any())).thenThrow(Exception());

        final result = datasource.deleteDiscount(discount: discountMock);

        await expectLater(result, throwsA(isA<DiscountError>()));

        verify(() => localStorage.read<List<String>>(any())).called(1);
        verify(() => localStorage.write<List<String>>(any(), any())).called(1);
      });
    });
  });
}
