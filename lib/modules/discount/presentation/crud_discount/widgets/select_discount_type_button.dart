import 'package:flutter/material.dart';

import '../../../../../core/enums/enums.dart';
import '../../../../../core/ui/themes/app_themes.dart';

class SelectDiscountTypeButton extends StatelessWidget {
  final DiscountType discountType;
  final Function(DiscountType value) onChanged;
  const SelectDiscountTypeButton({super.key, required this.onChanged, required this.discountType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('Tipo de desconto'),
        const SizedBox(height: 10),
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
        const SizedBox(height: 20),
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
          color: isActive ? AppThemes.primary : AppThemes.lightGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: isActive ? AppThemes.lightGrey : AppThemes.primary),
            ),
          ),
        ),
      ),
    );
  }
}
