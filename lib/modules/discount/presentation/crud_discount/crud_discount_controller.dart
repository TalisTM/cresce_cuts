import 'package:mobx/mobx.dart';

import '../../../../core/enums/enums.dart';

part 'crud_discount_controller.g.dart';

class CrudDiscountController = CrudDiscountControllerBase with _$CrudDiscountController;

abstract class CrudDiscountControllerBase with Store {
  @observable
  DiscountType discountType = DiscountType.ofBy;

  @action
  setDiscountType(DiscountType value) => discountType = value;

  @observable
  DateTime? activationDate;

  @action
  setActivationDate(DateTime value) => activationDate = value;

  @observable
  DateTime? deactivationDate;

  @action
  setDeactivationDate(DateTime value) => deactivationDate = value;

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um título.';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma descrição.';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o preço.';
    }
    return null;
  }

  String? validatePercent(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o valor percentual.';
    }
    final percent = double.parse(value);
    if (percent == 0 || percent > 100) {
      return 'Por favor, insira um percentual válido.';
    }
    return null;
  }

  String? validateTakesPaid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a quantidade.';
    }
    return null;
  }
}
