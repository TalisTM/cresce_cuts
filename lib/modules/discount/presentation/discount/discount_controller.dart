import 'package:mobx/mobx.dart';

import '../../../../core/enums/enums.dart';
import '../../domain/entities/discount_entity.dart';
import '../../domain/usecases/get_discounts_usecase.dart';

part 'discount_controller.g.dart';

class DiscountController = DiscountControllerBase with _$DiscountController;

abstract class DiscountControllerBase with Store {
  final GetDiscountsUseCase _getDiscountsUseCase;
  DiscountControllerBase({
    required GetDiscountsUseCase getDiscountsUseCase,
  }) : _getDiscountsUseCase = getDiscountsUseCase;

  @observable
  Status status = Status.intial;

  @observable
  List<DiscountEntity> discounts = ObservableList();

  @action
  Future<void> getDiscounts() async {
    status = Status.loading;
    await _getDiscountsUseCase().then((result) {
      result.fold(
        (error) => status = Status.error,
        (value) {
          discounts = value;
          status = Status.success;
        },
      );
    });
  }

  @action
  Future<void> createDiscount() async {}

  @action
  Future<void> updateDiscount() async {}

  @action
  Future<void> deleteDiscount() async {}
}
