import 'package:flutter/material.dart';

import '../../domain/entities/discount_entity.dart';

class DiscountDetailsPage extends StatelessWidget {
  final DiscountEntity discount;
  final VoidCallback onEditTap;
  const DiscountDetailsPage({super.key, required this.discount, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descontos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            _DiscountInfo(),
            Text(discount.product.title),
            Text(discount.product.description),
            ElevatedButton(
              onPressed: onEditTap,
              child: const Text("Editar desconto"),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscountInfo extends StatelessWidget {
  const _DiscountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Text('Leve 5 pague 3'),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Text('R\$ 14,50'),
          ),
        ),
      ],
    );
  }
}
