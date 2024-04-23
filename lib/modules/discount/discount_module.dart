import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_module.dart';
import 'data/datasources/discount_datasource.dart';
import 'data/datasources/discount_datasource_impl.dart';
import 'data/repositories/discount_repository_impl.dart';
import 'domain/repositories/discount_repository.dart';
import 'domain/usecases/get_discounts_usecase.dart';
import 'presentation/discount/discount_controller.dart';
import 'presentation/discount/discount_page.dart';

class DiscountModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.addLazySingleton<DiscountDatasource>(DiscountDatasourceImpl.new);
    i.addLazySingleton<DiscountRepository>(DiscountRepositoryImpl.new);
    i.addLazySingleton<GetDiscountsUseCase>(GetDiscountsUseCaseImpl.new);
    i.addLazySingleton<DiscountController>(DiscountController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const DiscountPage());
  }
}
