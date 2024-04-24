import 'discount_entity.dart';

class DiscountPercentageEntity extends DiscountEntity {
  final double percentage;
  const DiscountPercentageEntity({
    required super.id,
    required super.product,
    required super.isActive,
    required super.activationDate,
    required super.deactivationDate,
    required this.percentage,
  });

  @override
  List<Object?> get props => [percentage];
}
