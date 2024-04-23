import 'package:mobx/mobx.dart';

import '../../../../core/enums/enums.dart';

part 'crud_discount_controller.g.dart';

class CrudDiscountController = CrudDiscountControllerBase with _$CrudDiscountController;

abstract class CrudDiscountControllerBase with Store {
  @observable
  bool isUpdate = false;

  @action
  setIsUpdate(bool value) => isUpdate = value;

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
}
