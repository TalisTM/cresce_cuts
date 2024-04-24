import 'package:mobx/mobx.dart';

import '../../../../core/enums/enums.dart';
import '../../domain/entities/discount_entity.dart';
import '../../domain/usecases/create_discount_usecase.dart';
import '../../domain/usecases/delete_discount_usecase.dart';
import '../../domain/usecases/get_discounts_usecase.dart';
import '../../domain/usecases/update_discount_usecase.dart';

part 'discount_controller.g.dart';

class DiscountController = DiscountControllerBase with _$DiscountController;

abstract class DiscountControllerBase with Store {
  final GetDiscountsUseCase _getDiscountsUseCase;
  final CreateDiscountUseCase _createDiscountUseCase;
  final UpdateDiscountUseCase _updateDiscountUseCase;
  final DeleteDiscountUseCase _deleteDiscountUseCase;
  DiscountControllerBase({
    required GetDiscountsUseCase getDiscountsUseCase,
    required CreateDiscountUseCase createDiscountUseCase,
    required UpdateDiscountUseCase updateDiscountUseCase,
    required DeleteDiscountUseCase deleteDiscountUseCase,
  })  : _deleteDiscountUseCase = deleteDiscountUseCase,
        _updateDiscountUseCase = updateDiscountUseCase,
        _createDiscountUseCase = createDiscountUseCase,
        _getDiscountsUseCase = getDiscountsUseCase;

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
  Future<void> createDiscount(DiscountEntity discount) async {
    status = Status.loading;
    await _createDiscountUseCase(discount: discount).then((result) {
      result.fold(
        (error) => status = Status.error,
        (_) => getDiscounts(),
      );
    });
  }

  @action
  Future<void> updateDiscount(DiscountEntity discount) async {
    status = Status.loading;
    await _updateDiscountUseCase(discount: discount).then((result) {
      result.fold(
        (error) => status = Status.error,
        (_) => getDiscounts(),
      );
    });
  }

  @action
  Future<void> deleteDiscount(DiscountEntity discount) async {
    status = Status.loading;
    await _deleteDiscountUseCase(discount: discount).then((result) {
      result.fold(
        (error) => status = Status.error,
        (_) => getDiscounts(),
      );
    });
  }
}
