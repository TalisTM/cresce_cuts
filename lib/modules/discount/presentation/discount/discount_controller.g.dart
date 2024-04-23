// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DiscountController on DiscountControllerBase, Store {
  late final _$statusAtom =
      Atom(name: 'DiscountControllerBase.status', context: context);

  @override
  Status get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(Status value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$discountsAtom =
      Atom(name: 'DiscountControllerBase.discounts', context: context);

  @override
  List<DiscountEntity> get discounts {
    _$discountsAtom.reportRead();
    return super.discounts;
  }

  @override
  set discounts(List<DiscountEntity> value) {
    _$discountsAtom.reportWrite(value, super.discounts, () {
      super.discounts = value;
    });
  }

  late final _$getDiscountsAsyncAction =
      AsyncAction('DiscountControllerBase.getDiscounts', context: context);

  @override
  Future<void> getDiscounts() {
    return _$getDiscountsAsyncAction.run(() => super.getDiscounts());
  }

  @override
  String toString() {
    return '''
status: ${status},
discounts: ${discounts}
    ''';
  }
}
