import 'package:cresce_cuts/core/enums/enums.dart';
import 'package:cresce_cuts/modules/discount/domain/entities/discount_entity.dart';
import 'package:cresce_cuts/modules/discount/domain/exception/discount_exception.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/create_discount_usecase.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/delete_discount_usecase.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/get_discounts_usecase.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/update_discount_usecase.dart';
import 'package:cresce_cuts/modules/discount/presentation/discount/discount_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../discount_mocks.dart';

void main() {
  late GetDiscountsUseCase getDiscountsUseCase;
  late CreateDiscountUseCase createDiscountUseCase;
  late UpdateDiscountUseCase updateDiscountUseCase;
  late DeleteDiscountUseCase deleteDiscountUseCase;
  late DiscountController discountController;

  setUp(() {
    registerFallbackValue(discountMock);
    getDiscountsUseCase = GetDiscountsUseCaseMock();
    createDiscountUseCase = CreateDiscountUseCaseMock();
    updateDiscountUseCase = UpdateDiscountUseCaseMock();
    deleteDiscountUseCase = DeleteDiscountUseCaseMock();
    discountController = DiscountController(
      getDiscountsUseCase: getDiscountsUseCase,
      createDiscountUseCase: createDiscountUseCase,
      updateDiscountUseCase: updateDiscountUseCase,
      deleteDiscountUseCase: deleteDiscountUseCase,
    );
  });

  group('DiscountController', () {
    group('getDiscounts', () {
      test('Deve buscar uma lista de descontos', () async {
        when(() => getDiscountsUseCase()).thenAnswer((_) async => Right(discountsMock));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.getDiscounts();

        expect(discountController.discounts, discountsMock);
        expect(discountController.status, Status.success);

        verify(() => getDiscountsUseCase()).called(1);
      });

      test('Deve retornar um erro ao buscar a lista de descontos', () async {
        when(() => getDiscountsUseCase()).thenAnswer((_) async => Left(DiscountError()));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.getDiscounts();

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.error);

        verify(() => getDiscountsUseCase()).called(1);
      });
    });

    group('createDiscount', () {
      test('Deve salvar no banco o novo desconto', () async {
        when(() => createDiscountUseCase(discount: any(named: 'discount')))
            .thenAnswer((_) async => const Right(unit));
        when(() => getDiscountsUseCase()).thenAnswer((_) async => Right(discountsMock));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.createDiscount(discountMock);

        expect(discountController.discounts, discountsMock);
        expect(discountController.status, Status.success);

        verify(() => createDiscountUseCase(discount: any(named: 'discount'))).called(1);
        verify(() => getDiscountsUseCase()).called(1);
      });

      test('Deve retornar um erro ao salvar o novo desconto', () async {
        when(() => createDiscountUseCase(discount: any(named: 'discount')))
            .thenAnswer((_) async => Left(DiscountError()));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.createDiscount(discountMock);

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.error);

        verify(() => createDiscountUseCase(discount: any(named: 'discount'))).called(1);
        verifyNever(() => getDiscountsUseCase());
      });
    });

    group('toggleIsActvateDiscount', () {
      test('Deve mudar o isActive do desconto no banco', () async {
        when(() => updateDiscountUseCase(discount: any(named: 'discount')))
            .thenAnswer((_) async => const Right(unit));
        when(() => getDiscountsUseCase()).thenAnswer((_) async => Right(discountsMock));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.updateDiscount(discountMock);

        expect(discountController.discounts, discountsMock);
        expect(discountController.status, Status.success);

        verify(() => updateDiscountUseCase(discount: any(named: 'discount'))).called(1);
        verify(() => getDiscountsUseCase()).called(1);
      });

      test('Deve retornar um erro ao fazer o toggle do desconto', () async {
        when(() => updateDiscountUseCase(discount: any(named: 'discount')))
            .thenAnswer((_) async => Left(DiscountError()));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.updateDiscount(discountMock);

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.error);

        verify(() => updateDiscountUseCase(discount: any(named: 'discount'))).called(1);
        verifyNever(() => getDiscountsUseCase());
      });
    });
    group('updateDiscount', () {
      test('Deve atualizar no banco o novo desconto', () async {
        when(() => updateDiscountUseCase(discount: any(named: 'discount')))
            .thenAnswer((_) async => const Right(unit));
        when(() => getDiscountsUseCase()).thenAnswer((_) async => Right(discountsMock));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.updateDiscount(discountMock);

        expect(discountController.discounts, discountsMock);
        expect(discountController.status, Status.success);

        verify(() => updateDiscountUseCase(discount: any(named: 'discount'))).called(1);
        verify(() => getDiscountsUseCase()).called(1);
      });

      test('Deve retornar um erro ao atualizar o desconto', () async {
        when(() => updateDiscountUseCase(discount: any(named: 'discount')))
            .thenAnswer((_) async => Left(DiscountError()));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.updateDiscount(discountMock);

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.error);

        verify(() => updateDiscountUseCase(discount: any(named: 'discount'))).called(1);
        verifyNever(() => getDiscountsUseCase());
      });
    });

    group('deleteDiscount', () {
      test('Deve deletar no banco desconto', () async {
        when(() => deleteDiscountUseCase(discount: any(named: 'discount')))
            .thenAnswer((_) async => const Right(unit));
        when(() => getDiscountsUseCase()).thenAnswer((_) async => Right(discountsMock));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.deleteDiscount(discountMock);

        expect(discountController.discounts, discountsMock);
        expect(discountController.status, Status.success);

        verify(() => deleteDiscountUseCase(discount: any(named: 'discount'))).called(1);
        verify(() => getDiscountsUseCase()).called(1);
      });

      test('Deve retornar um erro ao deletar o desconto', () async {
        when(() => deleteDiscountUseCase(discount: any(named: 'discount')))
            .thenAnswer((_) async => Left(DiscountError()));

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.intial);

        await discountController.deleteDiscount(discountMock);

        expect(discountController.discounts, const <DiscountEntity>[]);
        expect(discountController.status, Status.error);

        verify(() => deleteDiscountUseCase(discount: any(named: 'discount'))).called(1);
        verifyNever(() => getDiscountsUseCase());
      });
    });
  });
}
