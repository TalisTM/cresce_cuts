import 'package:cresce_cuts/modules/discount/domain/exception/discount_exception.dart';
import 'package:cresce_cuts/modules/discount/domain/repositories/discount_repository.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/update_discount_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../discount_mocks.dart';

void main() {
  late DiscountRepository repository;
  late UpdateDiscountUseCase useCase;

  setUp(() {
    registerFallbackValue(discountMock);
    repository = DiscountRepositoryMock();
    useCase = UpdateDiscountUseCaseImpl(repository: repository);
  });

  group('UpdateDiscountUseCase', () {
    test('Deve salvar o desconto atualizado', () async {
      when(() => repository.updateDiscount(discount: any(named: 'discount')))
          .thenAnswer((_) async => const Right(unit));

      final result = await useCase(discount: discountMock);

      verify(() => repository.updateDiscount(discount: any(named: 'discount'))).called(1);
      expect(result, const Right(unit));
    });

    test('Deve retornar um erro', () async {
      when(() => repository.updateDiscount(discount: any(named: 'discount')))
          .thenAnswer((_) async => Left(DiscountError()));

      final result = await useCase(discount: discountMock);

      verify(() => repository.updateDiscount(discount: any(named: 'discount'))).called(1);
      expect(result.fold(id, id), isA<DiscountError>());
    });
  });
}