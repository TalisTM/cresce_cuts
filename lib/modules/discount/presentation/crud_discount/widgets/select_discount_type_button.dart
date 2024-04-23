import 'package:flutter/material.dart';

import '../../../../../core/enums/enums.dart';

class SelectDiscountTypeButton extends StatelessWidget {
  final DiscountType discountType;
  final Function(DiscountType value) onChanged;
  const SelectDiscountTypeButton({super.key, required this.onChanged, required this.discountType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Tipo de desconto'),
        Row(
          children: [
            _SelectButton(
              label: 'de/por',
              isActive: discountType == DiscountType.ofBy,
              onTap: () => onChanged(DiscountType.ofBy),
            ),
            const SizedBox(width: 5),
            _SelectButton(
              label: 'porcentagem',
              isActive: discountType == DiscountType.percentage,
              onTap: () => onChanged(DiscountType.percentage),
            ),
            const SizedBox(width: 5),
            _SelectButton(
              label: 'leve + page',
              isActive: discountType == DiscountType.takePay,
              onTap: () => onChanged(DiscountType.takePay),
            ),
          ],
        ),
      ],
    );
  }
}

class _SelectButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _SelectButton({required this.label, required this.onTap, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Ink(
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Text(label, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
