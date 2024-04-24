import 'package:cresce_cuts/core/enums/enums.dart';
import 'package:cresce_cuts/modules/discount/presentation/crud_discount/crud_discount_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../discount_mocks.dart';

void main() {
  late CrudDiscountController controller;

  setUp(() {
    controller = CrudDiscountController();
  });

  group('CrudDiscountController', () {
    group('setDiscountType', () {
      test('Deve setar o DiscountType recebido', () {
        expect(controller.discountType, DiscountType.ofBy);

        controller.setDiscountType(DiscountType.percentage);

        expect(controller.discountType, DiscountType.percentage);
      });
    });

    group('setActivationDate', () {
      test('Deve setar o activationDate recebido', () {
        expect(controller.activationDate, null);

        controller.setActivationDate(dateTimeMock);

        expect(controller.activationDate, dateTimeMock);
      });
    });

    group('setDeactivationDate', () {
      test('Deve setar o deactivationDate recebido', () {
        expect(controller.deactivationDate, null);

        controller.setDeactivationDate(dateTimeMock);

        expect(controller.deactivationDate, dateTimeMock);
      });
    });
  });
}
