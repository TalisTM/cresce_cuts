import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_module.dart';
import 'data/datasources/discount_datasource.dart';
import 'data/datasources/discount_datasource_impl.dart';
import 'data/repositories/discount_repository_impl.dart';
import 'domain/repositories/discount_repository.dart';
import 'domain/usecases/create_discount_usecase.dart';
import 'domain/usecases/delete_discount_usecase.dart';
import 'domain/usecases/get_discounts_usecase.dart';
import 'domain/usecases/update_discount_usecase.dart';
import 'presentation/crud_discount/crud_discount_controller.dart';
import 'presentation/crud_discount/crud_discount_page.dart';
import 'presentation/discount/discount_controller.dart';
import 'presentation/discount/discount_page.dart';
import 'presentation/discount_details/discount_details_page.dart';

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
    i.addLazySingleton<CreateDiscountUseCase>(CreateDiscountUseCaseImpl.new);
    i.addLazySingleton<UpdateDiscountUseCase>(UpdateDiscountUseCaseImpl.new);
    i.addLazySingleton<DeleteDiscountUseCase>(DeleteDiscountUseCaseImpl.new);
    i.addLazySingleton<DiscountController>(DiscountController.new);
    i.add<CrudDiscountController>(CrudDiscountController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const DiscountPage());
    r.child(
      '/crud-discount',
      child: (context) => CrudDiscountPage(
        product: r.args.data['product'],
        discount: r.args.data['discount'],
      ),
    );
    r.child('/discount-details', child: (context) => DiscountDetailsPage(discount: r.args.data));
  }
}
