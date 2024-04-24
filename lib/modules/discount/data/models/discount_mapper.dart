import 'dart:convert';

import '../../../product/data/models/product_mapper.dart';
import '../../domain/entities/discount_entity.dart';
import '../../domain/entities/discount_of_by_entity.dart';
import '../../domain/entities/discount_percentage_entity.dart';
import '../../domain/entities/discount_takes_paid_entity.dart';

class DiscountMapper {
  DiscountMapper._();

  static const _discountOfByKey = 'discountOfBy';
  static const _discountPercentageKey = 'discountPercentage';
  static const _discountTakesPaidKey = 'discountTakesPaid';

  static String toJson(DiscountEntity discount) {
    var map = <String, dynamic>{};

    map['id'] = discount.id;
    map['product'] = ProductMapper.toMap(discount.product);
    map['isActive'] = discount.isActive;
    map['activationDate'] = discount.activationDate.millisecondsSinceEpoch;
    map['deactivationDate'] = discount.deactivationDate.millisecondsSinceEpoch;

    if (discount is DiscountOfByEntity) {
      map['howMuckPay'] = discount.howMuckPay;
      map['discountType'] = _discountOfByKey;
    } else if (discount is DiscountPercentageEntity) {
      map['percentage'] = discount.percentage;
      map['discountType'] = _discountPercentageKey;
    } else if (discount is DiscountTakesPaidEntity) {
      map['amountPaid'] = discount.amountPaid;
      map['amountTakes'] = discount.amountTakes;
      map['discountType'] = _discountTakesPaidKey;
    }

    return json.encode(map);
  }

  static DiscountEntity fromJson(String source) {
    final map = json.decode(source) as Map<String, dynamic>;

    if (map['discountType'] == _discountOfByKey) {
      return DiscountOfByEntity(
        id: map['id'],
        product: ProductMapper.fromMap(map['product'] as Map<String, dynamic>),
        isActive: map['isActive'],
        activationDate: DateTime.fromMillisecondsSinceEpoch(map['activationDate'] as int),
        deactivationDate: DateTime.fromMillisecondsSinceEpoch(map['deactivationDate'] as int),
        howMuckPay: map['howMuckPay'] as double,
      );
    } else if (map['discountType'] == _discountPercentageKey) {
      return DiscountPercentageEntity(
        id: map['id'],
        product: ProductMapper.fromMap(map['product'] as Map<String, dynamic>),
        isActive: map['isActive'],
        activationDate: DateTime.fromMillisecondsSinceEpoch(map['activationDate'] as int),
        deactivationDate: DateTime.fromMillisecondsSinceEpoch(map['deactivationDate'] as int),
        percentage: map['percentage'] as double,
      );
    } else {
      return DiscountTakesPaidEntity(
        id: map['id'],
        product: ProductMapper.fromMap(map['product'] as Map<String, dynamic>),
        isActive: map['isActive'],
        activationDate: DateTime.fromMillisecondsSinceEpoch(map['activationDate'] as int),
        deactivationDate: DateTime.fromMillisecondsSinceEpoch(map['deactivationDate'] as int),
        amountTakes: map['amountTakes'] as int,
        amountPaid: map['amountPaid'] as int,
      );
    }
  }

  static DiscountEntity toggleIsActivate(DiscountEntity discount) {
    if (discount is DiscountOfByEntity) {
      return DiscountOfByEntity(
        id: discount.id,
        product: discount.product,
        isActive: !discount.isActive,
        activationDate: discount.activationDate,
        deactivationDate: discount.deactivationDate,
        howMuckPay: discount.howMuckPay,
      );
    } else if (discount is DiscountPercentageEntity) {
      return DiscountPercentageEntity(
        id: discount.id,
        product: discount.product,
        isActive: !discount.isActive,
        activationDate: discount.activationDate,
        deactivationDate: discount.deactivationDate,
        percentage: discount.percentage,
      );
    } else {
      discount as DiscountTakesPaidEntity;
      return DiscountTakesPaidEntity(
        id: discount.id,
        product: discount.product,
        isActive: !discount.isActive,
        activationDate: discount.activationDate,
        deactivationDate: discount.deactivationDate,
        amountTakes: discount.amountTakes,
        amountPaid: discount.amountPaid,
      );
    }
  }
}
