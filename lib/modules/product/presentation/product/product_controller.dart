import 'package:mobx/mobx.dart';

import '../../../../core/enums/enums.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'product_controller.g.dart';

class ProductController = ProductControllerBase with _$ProductController;

abstract class ProductControllerBase with Store {
  final GetProductsUseCase _getProductsUseCase;
  ProductControllerBase({
    required GetProductsUseCase getProductsUseCase,
  }) : _getProductsUseCase = getProductsUseCase;

  @observable
  Status status = Status.intial;

  @observable
  List<ProductEntity> products = ObservableList();

  @action
  Future<void> getProducts() async {
    status = Status.loading;
    await _getProductsUseCase().then((result) {
      result.fold(
        (error) => status = Status.error,
        (value) {
          products = value;
          status = Status.success;
        },
      );
    });
  }
}
