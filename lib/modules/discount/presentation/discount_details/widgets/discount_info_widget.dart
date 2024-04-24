import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import '../../../../../core/ui/themes/app_themes.dart';
import '../../../domain/entities/discount_entity.dart';
import '../../../domain/entities/discount_of_by_entity.dart';
import '../../../domain/entities/discount_percentage_entity.dart';
import '../../../domain/entities/discount_takes_paid_entity.dart';

class DiscountInfoWidget extends StatelessWidget {
  final DiscountEntity discount;
  const DiscountInfoWidget({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    final discount = this.discount;

    String title = '';
    String subtitle = '';
    String? subTitlelineThrough;

    if (discount is DiscountOfByEntity) {
      final discountValue = discount.product.price - discount.howMuckPay;
      title = 'Economize ${UtilBrasilFields.obterReal(discountValue)}';
      subtitle = UtilBrasilFields.obterReal(discount.howMuckPay);
      subTitlelineThrough = UtilBrasilFields.obterReal(discount.product.price);
    } else if (discount is DiscountPercentageEntity) {
      final price = discount.product.price;
      final discountValue = price - (price * (discount.percentage / 100));
      title = '${discount.percentage.toInt()}% Desconto';
      subtitle = UtilBrasilFields.obterReal(discountValue);
      subTitlelineThrough = UtilBrasilFields.obterReal(discount.product.price);
    } else if (discount is DiscountTakesPaidEntity) {
      title = 'Leve ${discount.amountTakes} Pague ${discount.amountPaid}';
      subtitle = UtilBrasilFields.obterReal(discount.product.price);
    }

    final decoration = BoxDecoration(
      color: AppThemes.primary,
      borderRadius: BorderRadius.circular(3),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: decoration,
            child: Text(
              title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: decoration,
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              if (subTitlelineThrough != null) ...[
                const SizedBox(width: 10),
                Text(
                  subTitlelineThrough,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(decoration: TextDecoration.lineThrough),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
