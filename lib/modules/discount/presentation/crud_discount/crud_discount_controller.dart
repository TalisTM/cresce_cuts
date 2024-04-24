// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/enums/enums.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/entities/discount_entity.dart';
import '../../domain/entities/discount_of_by_entity.dart';
import '../../domain/entities/discount_percentage_entity.dart';
import '../../domain/entities/discount_takes_paid_entity.dart';
import '../discount/discount_controller.dart';

part 'crud_discount_controller.g.dart';

class CrudDiscountController = CrudDiscountControllerBase with _$CrudDiscountController;

abstract class CrudDiscountControllerBase with Store {
  final DiscountController _discountController;
  CrudDiscountControllerBase({required DiscountController discountController})
      : _discountController = discountController;

  Future<void> onConfirm({
    required DiscountEntity? oldDiscount,
    required ProductEntity oldProduct,
    required String title,
    required String price,
    required String description,
    required DateTime activationDate,
    required DateTime deactivationDate,
    required String howMuchPay,
    required String percentageDiscount,
    required String amountPaid,
    required String amountTakes,
  }) async {
    final product = ProductEntity(
      id: oldProduct.id,
      title: title,
      price: UtilBrasilFields.converterMoedaParaDouble(price),
      category: oldProduct.category,
      description: description,
      image: oldProduct.image,
    );

    DiscountEntity discount;
    final id = oldDiscount?.id ?? DateTime.now().millisecondsSinceEpoch;
    final isActive = oldDiscount?.isActive ?? false;
    switch (discountType) {
      case DiscountType.ofBy:
        discount = DiscountOfByEntity(
          id: id,
          product: product,
          isActive: isActive,
          activationDate: activationDate,
          deactivationDate: deactivationDate,
          howMuckPay: UtilBrasilFields.converterMoedaParaDouble(howMuchPay),
        );
        break;
      case DiscountType.percentage:
        discount = DiscountPercentageEntity(
          id: id,
          product: product,
          isActive: isActive,
          activationDate: activationDate,
          deactivationDate: deactivationDate,
          percentage: double.parse(percentageDiscount),
        );
        break;
      case DiscountType.takePay:
        discount = DiscountTakesPaidEntity(
          id: id,
          product: product,
          isActive: isActive,
          activationDate: activationDate,
          deactivationDate: deactivationDate,
          amountPaid: int.parse(amountPaid),
          amountTakes: int.parse(amountTakes),
        );
        break;
      default:
        throw Exception('Not found Disconte Type Data');
    }
    oldDiscount != null
        ? await _discountController.updateDiscount(discount)
        : await _discountController.createDiscount(discount);
    Modular.to.pushNamedAndRemoveUntil('/discount', (p0) => false);
  }

  void onDelete(DiscountEntity discount) {
    _discountController.deleteDiscount(discount);
    Modular.to.pushNamedAndRemoveUntil('/discount', (p0) => false);
  }

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
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira um título.';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira uma descrição.';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira o preço.';
    }
    return null;
  }

  String? validatePercent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira o valor percentual.';
    }
    final percent = double.tryParse(value);
    if (percent == null || percent == 0 || percent > 100) {
      return 'Por favor, insira um percentual válido.';
    }
    return null;
  }

  String? validateTakesPaid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira a quantidade.';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Por favor, insira um percentual válido.';
    }
    return null;
  }
}
