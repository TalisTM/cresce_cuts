import 'dart:convert';

import '../../../../core/enums/enums.dart';
import '../../../product/data/models/product_mapper.dart';
import '../../domain/entities/discount_entity.dart';

class DiscountMapper {
  DiscountMapper._();

  static String toJson(DiscountEntity discount) {
    final map = <String, dynamic>{
      'id': discount.id,
      'product': ProductMapper.toMap(discount.product),
      'discountType': discount.discountType.name,
      'activationDate': discount.activationDate.millisecondsSinceEpoch,
      'deactivationDate': discount.deactivationDate.millisecondsSinceEpoch,
      'howMuckPay': discount.howMuckPay,
      'percentage': discount.percentage,
      'amountTakes': discount.amountTakes,
      'amountPaid': discount.amountPaid,
    };

    return json.encode(map);
  }

  static DiscountEntity fromJson(String source) {
    final map = json.decode(source) as Map<String, dynamic>;

    return DiscountEntity(
      id: map['id'],
      product: ProductMapper.fromMap(map['product'] as Map<String, dynamic>),
      discountType: DiscountType.values.byName(map['discountType']),
      activationDate: DateTime.fromMillisecondsSinceEpoch(map['activationDate'] as int),
      deactivationDate: DateTime.fromMillisecondsSinceEpoch(map['deactivationDate'] as int),
      howMuckPay: map['howMuckPay'] != null ? map['howMuckPay'] as double : null,
      percentage: map['percentage'] != null ? map['percentage'] as double : null,
      amountTakes: map['amountTakes'] != null ? map['amountTakes'] as int : null,
      amountPaid: map['amountPaid'] != null ? map['amountPaid'] as int : null,
    );
  }
}
