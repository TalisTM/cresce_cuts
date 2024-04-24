import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/contants/endpoints.dart';
import '../core/services/local_storage/local_storage.dart';
import '../core/services/local_storage/shared_preferences_local_storage_impl.dart';
import '../modules/discount/discount_module.dart';
import '../modules/product/product_module.dart';
import '../modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(i) {
    i.addInstance<Dio>(Dio(BaseOptions(baseUrl: Endpoints.baseUrl)));
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
  }

  @override
  void routes(r) {
    r.module('/', module: SplashModule());
    r.module('/discount', module: DiscountModule());
    r.module('/product', module: ProductModule());
  }
}
