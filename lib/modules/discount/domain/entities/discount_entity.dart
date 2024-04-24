import 'package:equatable/equatable.dart';

import '../../../product/domain/entities/product_entity.dart';

abstract class DiscountEntity extends Equatable {
  final int id;
  final ProductEntity product;
  final bool isActive;
  final DateTime activationDate;
  final DateTime deactivationDate;

  const DiscountEntity({
    required this.id,
    required this.product,
    required this.isActive,
    required this.activationDate,
    required this.deactivationDate,
  });

  @override
  List<Object?> get props => [
        id,
        product,
        isActive,
        activationDate,
        deactivationDate,
      ];
}
