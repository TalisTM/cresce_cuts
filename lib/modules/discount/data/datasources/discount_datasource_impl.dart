import 'dart:async';

import '../../../../core/contants/endpoints.dart';
import '../../../../core/services/local_storage/local_storage.dart';
import '../../domain/entities/discount_entity.dart';
import '../../domain/exception/discount_exception.dart';
import '../models/discount_mapper.dart';
import 'discount_datasource.dart';

class DiscountDatasourceImpl implements DiscountDatasource {
  final LocalStorage _localStorage;
  DiscountDatasourceImpl({required LocalStorage localStorage}) : _localStorage = localStorage;

  Never _genericError(Object e, StackTrace s) {
    throw DiscountError();
  }

  @override
  Future<List<DiscountEntity>> getDiscounts() async {
    try {
      final response = await _localStorage.read<List<String>>(Endpoints.discountKey);

      final discounts = <DiscountEntity>[];
      for (var discount in response!) {
        discounts.add(DiscountMapper.fromJson(discount));
      }
      return discounts;
    } catch (e, s) {
      _genericError(e, s);
    }
  }

  Future<void> _setDiscounts(List<DiscountEntity> discounts) async {
    final discountsJson = <String>[];
    for (var discount in discounts) {
      discountsJson.add(DiscountMapper.toJson(discount));
    }
    await _localStorage.write<List<String>>(Endpoints.discountKey, discountsJson);
  }

  @override
  Future<void> createDiscount({required DiscountEntity discount}) async {
    try {
      final discounts = await getDiscounts();
      discounts.add(discount);
      await _setDiscounts(discounts);
    } catch (e, s) {
      _genericError(e, s);
    }
  }

  @override
  Future<void> updateDiscount({required DiscountEntity discount}) async {
    try {
      final discounts = await getDiscounts();

      for (var d in discounts) {
        if (d.id == discount.id) {
          discounts.remove(d);
          discounts.add(discount);
          break;
        }
      }
      await _setDiscounts(discounts);
    } catch (e, s) {
      _genericError(e, s);
    }
  }

  @override
  Future<void> deleteDiscount({required DiscountEntity discount}) async {
    try {
      final discounts = await getDiscounts();

      for (var d in discounts) {
        if (d.id == discount.id) {
          discounts.remove(d);
          break;
        }
      }
      await _setDiscounts(discounts);
    } catch (e, s) {
      _genericError(e, s);
    }
  }
}
