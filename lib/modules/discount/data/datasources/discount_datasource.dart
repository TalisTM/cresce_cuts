import '../../domain/entities/discount_entity.dart';

abstract class DiscountDatasource {
  Future<List<DiscountEntity>> getDiscounts();
  Future<void> createDiscount({required DiscountEntity discount});
  Future<void> updateDiscount({required DiscountEntity discount});
  Future<void> deleteDiscount({required DiscountEntity discount});
}
