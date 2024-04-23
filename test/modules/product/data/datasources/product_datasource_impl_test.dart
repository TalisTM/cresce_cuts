import 'package:cresce_cuts/modules/product/data/datasources/product_datasource.dart';
import 'package:cresce_cuts/modules/product/data/datasources/product_datasource_impl.dart';
import 'package:cresce_cuts/modules/product/domain/exception/product_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../product_mocks.dart';

main() {
  late Dio dio;
  late ProductDatasource datasource;

  setUp(() {
    dio = DioMock();
    datasource = ProductDatasourceImpl(dio: dio);
  });

  group('ProductDatasource', () {
    group('getProducts', () {
      test('Deve retornar e retornar uma lista de produtos', () async {
        when(() => dio.get(any())).thenAnswer((invocation) async => responseMock);

        final result = await datasource.getProducts();

        expect(result, productsMock);

        verify(() => dio.get(any())).called(1);
      });

      test('deve retornar um erro', () {
        when(() => dio.get(any())).thenThrow(Exception()); //erro 404 ou similar

        final result = datasource.getProducts();

        expect(result, throwsA(isA<ProductError>()));

        verify(() => dio.get(any())).called(1);
      });
    });
  });
}
