import 'discount_entity.dart';

class DiscountOfByEntity extends DiscountEntity {
  final double howMuckPay;
  const DiscountOfByEntity({
    required super.id,
    required super.product,
    required super.activationDate,
    required super.deactivationDate,
    required this.howMuckPay,
  });

  @override
  List<Object?> get props => [howMuckPay];
}
