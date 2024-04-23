import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/entities/discount_entity.dart';
import 'crud_discount_controller.dart';
import 'widgets/select_discount_type_button.dart';

class CrudDiscountPage extends StatefulWidget {
  final DiscountEntity? discount;
  final ProductEntity? product;
  const CrudDiscountPage({super.key, this.discount, this.product});

  @override
  State<CrudDiscountPage> createState() => _CrudDiscountPageState();
}

class _CrudDiscountPageState extends State<CrudDiscountPage> {
  final controller = Modular.get<CrudDiscountController>();

  final titleEC = TextEditingController();
  final descriptionEC = TextEditingController();

  final priceEC = TextEditingController();

  final howMuchPayEC = TextEditingController();

  final percentageDiscountEC = TextEditingController();

  final amountTakesEC = TextEditingController();
  final amountPaidEC = TextEditingController();

  @override
  void initState() {
    if (widget.discount != null) {
      controller.setIsUpdate(true);

      titleEC.text = widget.discount!.product.title;
      descriptionEC.text = widget.discount!.product.description;
      priceEC.text = widget.discount!.product.price.toString();

      switch (widget.discount!.discountType) {
        case DiscountType.ofBy:
          howMuchPayEC.text = widget.discount!.howMuckPay?.toString() ?? '';
          break;
        case DiscountType.percentage:
          percentageDiscountEC.text = widget.discount!.percentage?.toString() ?? '';
          break;
        case DiscountType.takePay:
          amountTakesEC.text = widget.discount!.amountTakes?.toString() ?? '';
          amountPaidEC.text = widget.discount!.amountPaid?.toString() ?? '';
          break;
      }
    } else {
      titleEC.text = widget.product!.title;
      descriptionEC.text = widget.product!.description;
      priceEC.text = widget.product!.price.toString();
    }

    super.initState();
  }

  @override
  void dispose() {
    titleEC.dispose();
    descriptionEC.dispose();

    priceEC.dispose();

    howMuchPayEC.dispose();

    percentageDiscountEC.dispose();

    amountTakesEC.dispose();
    amountPaidEC.dispose();
    super.dispose();
  }

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
            CustomTextField(
              controller: titleEC,
              label: 'Nome do desconto',
            ),
            CustomTextField(
              controller: descriptionEC,
              label: 'Descrição',
              maxLines: 4,
            ),
            Observer(
              builder: (_) {
                return Column(
                  children: [
                    SelectDiscountTypeButton(
                      discountType: controller.discountType,
                      onChanged: (value) => controller.setDiscountType(value),
                    ),
                    if (controller.discountType == DiscountType.ofBy)
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            controller: priceEC,
                            label: 'Preço "DE"',
                          )),
                          const SizedBox(width: 10),
                          Expanded(
                              child: CustomTextField(
                            controller: howMuchPayEC,
                            label: 'Preço "POR"',
                          )),
                        ],
                      ),
                    if (controller.discountType == DiscountType.percentage)
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            controller: priceEC,
                            label: 'Preço',
                          )),
                          const SizedBox(width: 10),
                          Expanded(
                              child: CustomTextField(
                            controller: howMuchPayEC,
                            label: 'Percentual de desconto',
                          )),
                        ],
                      ),
                    if (controller.discountType == DiscountType.takePay) ...[
                      CustomTextField(
                        controller: priceEC,
                        label: 'Preço',
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            controller: amountTakesEC,
                            label: 'Leve',
                          )),
                          const SizedBox(width: 10),
                          Expanded(
                              child: CustomTextField(
                            controller: amountPaidEC,
                            label: 'Pague',
                          )),
                        ],
                      ),
                    ],
                  ],
                );
              },
            ),
            const Text("validade"),
            Observer(
              builder: (_) {
                final activationDate = controller.activationDate;
                final deactivationDate = controller.deactivationDate;
                return Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          await _selectDate(
                            context: context,
                            onChanged: (value) => controller.setActivationDate(value),
                            firstDate: DateTime.now(),
                          );
                        },
                        child: Column(
                          children: [
                            const Text('Data ativação'),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Text(activationDate?.toString() ?? '-'),
                            ),
                          ],
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (activationDate == null) return;
                          await _selectDate(
                            context: context,
                            onChanged: (value) => controller.setDeactivationDate(value),
                            firstDate: activationDate,
                          );
                        },
                        child: Column(
                          children: [
                            const Text('Data desativação'),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Text(deactivationDate?.toString() ?? '-'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Observer(
              builder: (_) {
                return ElevatedButton(
                  onPressed: () {
                    if (controller.isUpdate) {
                      final product = ProductEntity(
                        id: widget.discount!.product.id,
                        title: titleEC.text,
                        price: double.parse(priceEC.text),
                        category: widget.discount!.product.category,
                        description: descriptionEC.text,
                        image: widget.discount!.product.image,
                      );

                      final discount = DiscountEntity(
                        id: widget.discount!.id,
                        product: product,
                        discountType: controller.discountType,
                        activationDate: controller.activationDate!,
                        deactivationDate: controller.deactivationDate!,
                      );

                      Modular.to.pop(discount);
                    } else {
                      final product = ProductEntity(
                        id: widget.product!.id,
                        title: titleEC.text,
                        price: double.parse(priceEC.text),
                        category: widget.product!.category,
                        description: descriptionEC.text,
                        image: widget.product!.image,
                      );

                      final discount = DiscountEntity(
                        id: DateTime.now().millisecondsSinceEpoch,
                        product: product,
                        discountType: controller.discountType,
                        activationDate: controller.activationDate!,
                        deactivationDate: controller.deactivationDate!,
                        howMuckPay: controller.discountType == DiscountType.ofBy
                            ? double.parse(howMuchPayEC.text)
                            : null,
                        percentage: controller.discountType == DiscountType.percentage
                            ? double.parse(percentageDiscountEC.text)
                            : null,
                        amountPaid: controller.discountType == DiscountType.takePay
                            ? int.parse(amountPaidEC.text)
                            : null,
                        amountTakes: controller.discountType == DiscountType.takePay
                            ? int.parse(amountTakesEC.text)
                            : null,
                      );

                      Modular.to.pop(discount);
                    }
                  },
                  child: Text(controller.isUpdate ? 'Atualizar' : 'Salvar'),
                );
              },
            )
          ],
        ),
      ),
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
    ).then((selectedDate) async {
      if (selectedDate != null) {
        await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 7, minute: 0),
        ).then((selectedTime) {
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
        });
      }
    });
  }
}
