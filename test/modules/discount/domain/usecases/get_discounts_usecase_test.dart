import 'package:cresce_cuts/modules/discount/domain/exception/discount_exception.dart';
import 'package:cresce_cuts/modules/discount/domain/repositories/discount_repository.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/get_discounts_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../discount_mocks.dart';

void main() {
  late DiscountRepository repository;
  late GetDiscountsUseCase useCase;

  setUp(() {
    repository = DiscountRepositoryMock();
    useCase = GetDiscountsUseCaseImpl(repository: repository);
  });

  group('GetDiscountsUseCase', () {
    test('Deve retornar uma lista de produtos', () async {
      when(() => repository.getDiscounts()).thenAnswer((_) async => Right(discountsMock));

      final result = await useCase();

      verify(() => repository.getDiscounts()).called(1);
      expect(result, Right(discountsMock));
    });

    test('Deve retornar um erro', () async {
      when(() => repository.getDiscounts()).thenAnswer((_) async => Left(DiscountError()));

      final result = await useCase();

      verify(() => repository.getDiscounts()).called(1);
      expect(result.fold(id, id), isA<DiscountError>());
    });
  });
}
