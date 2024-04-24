import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/discount_entity.dart';
import 'widgets/discount_info_widget.dart';

class DiscountDetailsPage extends StatelessWidget {
  final DiscountEntity discount;
  const DiscountDetailsPage({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descontos'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Align(
                    alignment: Alignment.topRight,
                    child: Switch(value: true, onChanged: (_) {}),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(discount.product.image),
                    ),
                  ),
                  DiscountInfoWidget(discount: discount),
                  Text(discount.product.title),
                  Text(discount.product.description),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: ElevatedButton(
                    onPressed: () => Modular.to.pushNamed(
                      '/discount/crud-discount',
                      arguments: {'product': discount.product, 'discount': discount},
                    ),
                    child: const Text("Editar desconto"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}