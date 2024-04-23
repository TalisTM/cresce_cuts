// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crud_discount_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CrudDiscountController on CrudDiscountControllerBase, Store {
  late final _$isUpdateAtom =
      Atom(name: 'CrudDiscountControllerBase.isUpdate', context: context);

  @override
  bool get isUpdate {
    _$isUpdateAtom.reportRead();
    return super.isUpdate;
  }

  @override
  set isUpdate(bool value) {
    _$isUpdateAtom.reportWrite(value, super.isUpdate, () {
      super.isUpdate = value;
    });
  }

  late final _$discountTypeAtom =
      Atom(name: 'CrudDiscountControllerBase.discountType', context: context);

  @override
  DiscountType get discountType {
    _$discountTypeAtom.reportRead();
    return super.discountType;
  }

  @override
  set discountType(DiscountType value) {
    _$discountTypeAtom.reportWrite(value, super.discountType, () {
      super.discountType = value;
    });
  }

  late final _$activationDateAtom =
      Atom(name: 'CrudDiscountControllerBase.activationDate', context: context);

  @override
  DateTime? get activationDate {
    _$activationDateAtom.reportRead();
    return super.activationDate;
  }

  @override
  set activationDate(DateTime? value) {
    _$activationDateAtom.reportWrite(value, super.activationDate, () {
      super.activationDate = value;
    });
  }

  late final _$deactivationDateAtom = Atom(
      name: 'CrudDiscountControllerBase.deactivationDate', context: context);

  @override
  DateTime? get deactivationDate {
    _$deactivationDateAtom.reportRead();
    return super.deactivationDate;
  }

  @override
  set deactivationDate(DateTime? value) {
    _$deactivationDateAtom.reportWrite(value, super.deactivationDate, () {
      super.deactivationDate = value;
    });
  }

  late final _$CrudDiscountControllerBaseActionController =
      ActionController(name: 'CrudDiscountControllerBase', context: context);

  @override
  dynamic setIsUpdate(bool value) {
    final _$actionInfo = _$CrudDiscountControllerBaseActionController
        .startAction(name: 'CrudDiscountControllerBase.setIsUpdate');
    try {
      return super.setIsUpdate(value);
    } finally {
      _$CrudDiscountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDiscountType(DiscountType value) {
    final _$actionInfo = _$CrudDiscountControllerBaseActionController
        .startAction(name: 'CrudDiscountControllerBase.setDiscountType');
    try {
      return super.setDiscountType(value);
    } finally {
      _$CrudDiscountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setActivationDate(DateTime value) {
    final _$actionInfo = _$CrudDiscountControllerBaseActionController
        .startAction(name: 'CrudDiscountControllerBase.setActivationDate');
    try {
      return super.setActivationDate(value);
    } finally {
      _$CrudDiscountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDeactivationDate(DateTime value) {
    final _$actionInfo = _$CrudDiscountControllerBaseActionController
        .startAction(name: 'CrudDiscountControllerBase.setDeactivationDate');
    try {
      return super.setDeactivationDate(value);
    } finally {
      _$CrudDiscountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isUpdate: ${isUpdate},
discountType: ${discountType},
activationDate: ${activationDate},
deactivationDate: ${deactivationDate}
    ''';
  }
}
