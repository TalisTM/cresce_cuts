import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/ui/widgets/empty_data.dart';
import '../../../../core/ui/widgets/loader.dart';
import '../../../../core/ui/widgets/try_again.dart';
import 'product_controller.dart';
import 'widgets/product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final controller = Modular.get<ProductController>();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() => controller.getProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha um produto'),
      ),
      body: Observer(
        builder: (context) {
          if (controller.status == Status.success) {
            final products = controller.products;
            return products.isEmpty
                ? const EmptyData(title: 'Vazio', content: 'Nenhum produto para ser mostrado')
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
          } else if (controller.status == Status.error) {
            return TryAgain(
              title: 'Ocorreu um erro ao buscar os produtos',
              tryAgain: () => controller.getProducts(),
            );
          }
          return const Loader();
        },
      ),
    );
  }
}
