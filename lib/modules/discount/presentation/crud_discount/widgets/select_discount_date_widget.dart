import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import '../../../../../core/ui/themes/app_themes.dart';

class SelectDiscountDateWidget extends StatelessWidget {
  final DateTime? activationDate;
  final DateTime? deactivationDate;
  final Function(DateTime) onActivationDate;
  final Function(DateTime) onDeactivationDate;
  const SelectDiscountDateWidget({
    Key? key,
    required this.activationDate,
    required this.deactivationDate,
    required this.onActivationDate,
    required this.onDeactivationDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text("Validade", style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 10),
        Row(
          children: [
            _DateTile(
              label: 'Data ativação',
              value: activationDate,
              onTap: () async {
                await _selectDate(
                  context: context,
                  onChanged: onActivationDate,
                  firstDate: DateTime.now(),
                );
              },
            ),
            const SizedBox(width: 10),
            _DateTile(
              label: 'Data desativação',
              onTap: () async {
                if (activationDate == null) return;
                await _selectDate(
                  context: context,
                  onChanged: onDeactivationDate,
                  firstDate: activationDate!,
                );
              },
              value: deactivationDate,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate({
    required BuildContext context,
    required Function(DateTime) onChanged,
    required DateTime firstDate,
  }) async {
    await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2025),
    ).then(
      (selectedDate) async {
        if (selectedDate != null) {
          await showTimePicker(
            context: context,
            initialTime: const TimeOfDay(hour: 7, minute: 0),
          ).then(
            (selectedTime) {
              if (selectedTime != null) {
                DateTime selectedDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                onChanged(selectedDateTime);
              }
            },
          );
        }
      },
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  const _DateTile({required this.onTap, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    String date = '__/__/____';
    if (value != null) {
      date = "${UtilData.obterDataDDMM(value!)} - ${UtilData.obterHoraHHMM(value!)}";
    }
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppThemes.lightGrey,
              border: Border.all(
                color: AppThemes.lightGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyLarge),
              Text(date, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
