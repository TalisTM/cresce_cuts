import 'package:flutter/material.dart';

import '../../../domain/entities/discount_entity.dart';
import '../../../domain/entities/discount_of_by_entity.dart';
import '../../../domain/entities/discount_percentage_entity.dart';
import '../../../domain/entities/discount_takes_paid_entity.dart';

class DiscountCard extends StatelessWidget {
  final DiscountEntity discount;
  final VoidCallback onTap;
  const DiscountCard({super.key, required this.discount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String discountType = '';
    if (discount is DiscountOfByEntity) discountType = 'De/Por';
    if (discount is DiscountPercentageEntity) discountType = 'percentual';
    if (discount is DiscountTakesPaidEntity) discountType = 'Leve pague';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey[200]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(discount.product.image),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(discount.product.title),
                              Text('Desconto: $discountType'),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Switch(value: true, onChanged: (_) {}),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Data ativação'),
                              Text(discount.activationDate.toString()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Data inativação'),
                              Text(discount.deactivationDate.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(color: Colors.grey[300], height: 1),
              TextButton(
                onPressed: () {},
                child: const Text('Ver desconto'),
              ),
              Container(color: Colors.grey[300], height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
