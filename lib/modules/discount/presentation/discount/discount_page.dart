import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/ui/widgets/empty_data.dart';
import '../../../../core/ui/widgets/loader.dart';
import '../../../../core/ui/widgets/try_again.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/entities/discount_entity.dart';
import 'discount_controller.dart';
import 'widgets/discount_card.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  final controller = Modular.get<DiscountController>();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() => controller.getDiscounts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descontos'),
      ),
      body: Observer(
        builder: (context) {
          if (controller.status == Status.success) {
            final discounts = controller.discounts;
            return discounts.isEmpty
                ? const EmptyData(
                    title: 'Vazio',
                    content:
                        'Nenhum desconto para ser mostrado, clique abaixo para criar novos descontos',
                  )
                : ListView.builder(
                    itemCount: controller.discounts.length,
                    itemBuilder: (context, index) {
                      return DiscountCard(discount: discounts[index]);
                    },
                  );
          } else if (controller.status == Status.error) {
            return TryAgain(
              title: 'Ocorreu um erro ao buscar seus descontos',
              tryAgain: () => controller.getDiscounts(),
            );
          }
          return const Loader();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () async {
            ProductEntity? product = await Modular.to.pushNamed('/product');
            if (product == null) return;

            DiscountEntity? discount =
                await Modular.to.pushNamed('/crud-discount', arguments: product);

            if (discount == null) return;
            controller.createDiscount();
          },
          child: const Text("Cadastrar desconto"),
        ),
      ),
    );
  }
}
