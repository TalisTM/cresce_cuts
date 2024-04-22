import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_module.dart';
import 'data/datasources/product_datasource.dart';
import 'data/datasources/product_datasource_impl.dart';
import 'data/repositories/register_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/get_products_usecase.dart';
import 'presentation/product/product_controller.dart';
import 'presentation/product/product_page.dart';

class ProductModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.addLazySingleton<ProductDatasource>(ProductDatasourceImpl.new);
    i.addLazySingleton<ProductRepository>(ProductRepositoryImpl.new);
    i.addLazySingleton<GetProductsUseCase>(GetProductsUseCaseImpl.new);
    i.addLazySingleton<ProductController>(ProductController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const ProductPage());
  }
}
