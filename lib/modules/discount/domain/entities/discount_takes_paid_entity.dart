import 'discount_entity.dart';

class DiscountTakesPaidEntity extends DiscountEntity {
  final int amountTakes;
  final int amountPaid;
  const DiscountTakesPaidEntity({
    required super.id,
    required super.product,
    required super.isActive,
    required super.activationDate,
    required super.deactivationDate,
    required this.amountTakes,
    required this.amountPaid,
  });

  @override
  List<Object?> get props => [amountTakes, amountPaid];
}
