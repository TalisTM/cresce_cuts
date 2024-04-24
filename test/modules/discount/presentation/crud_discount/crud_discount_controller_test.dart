import 'package:cresce_cuts/core/enums/enums.dart';
import 'package:cresce_cuts/modules/discount/presentation/crud_discount/crud_discount_controller.dart';
import 'package:cresce_cuts/modules/discount/presentation/discount/discount_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../discount_mocks.dart';

void main() {
  late DiscountController discountController;
  late CrudDiscountController crudDiscountController;

  setUp(() {
    discountController = DiscountControllerMock();
    crudDiscountController = CrudDiscountController(discountController: discountController);
  });

  group('CrudDiscountController', () {
    group('setDiscountType', () {
      test('Deve setar o DiscountType recebido', () {
        expect(crudDiscountController.discountType, DiscountType.ofBy);

        crudDiscountController.setDiscountType(DiscountType.percentage);

        expect(crudDiscountController.discountType, DiscountType.percentage);
      });
    });

    group('setActivationDate', () {
      test('Deve setar o activationDate recebido', () {
        expect(crudDiscountController.activationDate, null);

        crudDiscountController.setActivationDate(dateTimeMock);

        expect(crudDiscountController.activationDate, dateTimeMock);
      });
    });

    group('setDeactivationDate', () {
      test('Deve setar o deactivationDate recebido', () {
        expect(crudDiscountController.deactivationDate, null);

        crudDiscountController.setDeactivationDate(dateTimeMock);

        expect(crudDiscountController.deactivationDate, dateTimeMock);
      });
    });
  });
}
