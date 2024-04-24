import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/discount_entity.dart';
import '../../../domain/entities/discount_of_by_entity.dart';
import '../../../domain/entities/discount_percentage_entity.dart';
import '../../../domain/entities/discount_takes_paid_entity.dart';
import '../discount_controller.dart';

class DiscountCard extends StatelessWidget {
  final DiscountEntity discount;
  const DiscountCard({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    String discountType = '';
    if (discount is DiscountOfByEntity) discountType = 'De/Por';
    if (discount is DiscountPercentageEntity) discountType = 'percentual';
    if (discount is DiscountTakesPaidEntity) discountType = 'Leve pague';

    final activationDate =
        '${UtilData.obterDataDDMM(discount.activationDate)} - ${UtilData.obterHoraHHMM(discount.activationDate)}';
    final deactivationDate =
        '${UtilData.obterDataDDMM(discount.deactivationDate)} - ${UtilData.obterHoraHHMM(discount.deactivationDate)}';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                        child: Switch(
                            value: discount.isActive,
                            onChanged: (_) {
                              Modular.get<DiscountController>().toggleIsActvateDiscount(discount);
                            }),
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
                            Text(activationDate),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Data inativação'),
                            Text(deactivationDate),
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
              onPressed: () => Modular.to.pushNamed(
                '/discount/discount-details',
                arguments: discount.id,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ver desconto'),
                  SizedBox(width: 5),
                  Icon(Icons.remove_red_eye_outlined),
                ],
              ),
            ),
            Container(color: Colors.grey[300], height: 1),
          ],
        ),
      ),
    );
  }
}
