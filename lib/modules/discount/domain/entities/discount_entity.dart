import 'package:equatable/equatable.dart';

import '../../../../core/enums/enums.dart';
import '../../../product/domain/entities/product_entity.dart';

class DiscountEntity extends Equatable {
  final int id;
  final ProductEntity product;
  final DiscountType discountType;

  final DateTime activationDate;
  final DateTime deactivationDate;

  final double? howMuckPay;
  final double? percentage;
  final int? amountTakes;
  final int? amountPaid;

  const DiscountEntity({
    required this.id,
    required this.product,
    required this.discountType,
    required this.activationDate,
    required this.deactivationDate,
    this.howMuckPay,
    this.percentage,
    this.amountTakes,
    this.amountPaid,
  });

  @override
  List<Object?> get props => [
        id,
        product,
        discountType,
        activationDate,
        deactivationDate,
        howMuckPay,
        percentage,
        amountTakes,
        amountPaid,
      ];
}
