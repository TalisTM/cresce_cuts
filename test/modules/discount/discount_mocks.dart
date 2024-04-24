import 'package:cresce_cuts/core/services/local_storage/local_storage.dart';
import 'package:cresce_cuts/modules/discount/data/datasources/discount_datasource.dart';
import 'package:cresce_cuts/modules/discount/domain/entities/discount_of_by_entity.dart';
import 'package:cresce_cuts/modules/discount/domain/repositories/discount_repository.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/create_discount_usecase.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/delete_discount_usecase.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/get_discounts_usecase.dart';
import 'package:cresce_cuts/modules/discount/domain/usecases/update_discount_usecase.dart';
import 'package:cresce_cuts/modules/product/domain/entities/product_entity.dart';
import 'package:mocktail/mocktail.dart';

class LocalStorageMock extends Mock implements LocalStorage {}

class DiscountDatasourceMock extends Mock implements DiscountDatasource {}

class DiscountRepositoryMock extends Mock implements DiscountRepository {}

class GetDiscountsUseCaseMock extends Mock implements GetDiscountsUseCase {}

class CreateDiscountUseCaseMock extends Mock implements CreateDiscountUseCase {}

class UpdateDiscountUseCaseMock extends Mock implements UpdateDiscountUseCase {}

class DeleteDiscountUseCaseMock extends Mock implements DeleteDiscountUseCase {}


const discountsJsonMock = [
  '{"id":1,"product":{"id":2,"title":"title","price":20.0,"category":"category","description":"description","image":"image"},"isActive":true,"activationDate":1713582000000,"deactivationDate":1714186800000,"howMuckPay":10.0,"discountType":"discountOfBy"}',
  '{"id":1,"product":{"id":2,"title":"title","price":20.0,"category":"category","description":"description","image":"image"},"isActive":true,"activationDate":1713582000000,"deactivationDate":1714186800000,"howMuckPay":10.0,"discountType":"discountOfBy"}'
];

const _productMock = ProductEntity(
  id: 2,
  title: 'title',
  price: 20.0,
  category: 'category',
  description: 'description',
  image: 'image',
);

final discountMock = DiscountOfByEntity(
  id: 1,
  product: _productMock,
  isActive: true,
  activationDate: DateTime.parse('2024-04-20'),
  deactivationDate: DateTime.parse('2024-04-27'),
  howMuckPay: 10.0,
);

final discountsMock = [discountMock, discountMock];
