import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/contants/endpoints.dart';
import '../modules/product/product_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(i) {
    i.addInstance<Dio>(Dio(BaseOptions(baseUrl: Endpoints.baseUrl)));
  }

  @override
  void routes(r) {
    r.module('/', module: ProductModule());
  }
}
