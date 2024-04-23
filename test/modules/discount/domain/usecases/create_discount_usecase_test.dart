import 'package:cresce_cuts/modules/discount/domain/exception/discount_exception.dart';
import 'package:cresce_cuts/modules/discount/domain/repositories/discount_repository.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/create_discount_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../discount_mocks.dart';

void main() {
  late DiscountRepository repository;
  late CreateDiscountUseCase useCase;

  setUp(() {
    registerFallbackValue(discountMock);
    repository = DiscountRepositoryMock();
    useCase = CreateDiscountUseCaseImpl(repository: repository);
  });

  group('CreateDiscountUseCase', () {
    test('Deve salvar o desconto criado', () async {
      when(() => repository.createDiscount(discount: any(named: 'discount')))
          .thenAnswer((_) async => const Right(unit));

      final result = await useCase(discount: discountMock);

      verify(() => repository.createDiscount(discount: any(named: 'discount'))).called(1);
      expect(result, const Right(unit));
    });

    test('Deve retornar um erro', () async {
      when(() => repository.createDiscount(discount: any(named: 'discount')))
          .thenAnswer((_) async => Left(DiscountError()));

      final result = await useCase(discount: discountMock);

      verify(() => repository.createDiscount(discount: any(named: 'discount'))).called(1);
      expect(result.fold(id, id), isA<DiscountError>());
    });
  });
}
