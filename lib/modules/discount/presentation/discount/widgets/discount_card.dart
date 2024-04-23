import 'package:flutter/material.dart';

import '../../../domain/entities/discount_entity.dart';

class DiscountCard extends StatelessWidget {
  final DiscountEntity discount;
  const DiscountCard({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: InkWell(
        onTap: () {},
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Expanded(child: Text(discount.product.title)),
                  ],
                ),
              ),
              Container(color: Colors.grey[300], height: 1),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Descrição:'),
                    Text(discount.product.description),
                  ],
                ),
              ),
              Container(color: Colors.grey[300], height: 1),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Preço: R\$${discount.product.price.toStringAsFixed(2)}",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
