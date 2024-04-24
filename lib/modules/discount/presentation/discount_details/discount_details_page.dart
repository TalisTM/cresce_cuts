import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../discount/discount_controller.dart';
import 'widgets/discount_info_widget.dart';

class DiscountDetailsPage extends StatelessWidget {
  final int discountId;
  const DiscountDetailsPage({super.key, required this.discountId});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final discounts = Modular.get<DiscountController>().discounts;
        final discount = discounts.firstWhere((d) => d.id == discountId);

        return Scaffold(
          appBar: AppBar(title: const Text('Descontos')),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Align(
                        alignment: Alignment.topRight,
                        child: Switch(
                          value: discount.isActive,
                          onChanged: (_) {
                            Modular.get<DiscountController>().toggleIsActvateDiscount(discount);
                          },
                        ),
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
                      Text(discount.product.title, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Text(
                        discount.product.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
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
      },
    );
  }
}
