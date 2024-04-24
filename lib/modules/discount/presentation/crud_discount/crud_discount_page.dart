import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/entities/discount_entity.dart';
import '../../domain/entities/discount_of_by_entity.dart';
import '../../domain/entities/discount_percentage_entity.dart';
import '../../domain/entities/discount_takes_paid_entity.dart';
import '../discount/discount_controller.dart';
import 'crud_discount_controller.dart';
import 'widgets/select_discount_type_button.dart';

class CrudDiscountPage extends StatefulWidget {
  final DiscountEntity? discount;
  final ProductEntity product;
  const CrudDiscountPage({super.key, this.discount, required this.product});

  @override
  State<CrudDiscountPage> createState() => _CrudDiscountPageState();
}

class _CrudDiscountPageState extends State<CrudDiscountPage> {
  final controller = Modular.get<CrudDiscountController>();

  final formKey = GlobalKey<FormState>();

  final titleEC = TextEditingController();
  final descriptionEC = TextEditingController();

  final priceEC = TextEditingController();

  final howMuchPayEC = TextEditingController();

  final percentageDiscountEC = TextEditingController();

  final amountTakesEC = TextEditingController();
  final amountPaidEC = TextEditingController();

  @override
  void initState() {
    titleEC.text = widget.product.title;
    descriptionEC.text = widget.product.description;
    priceEC.text = widget.product.price.toString();

    final discount = widget.discount;
    if (discount == null) return;

    controller.setActivationDate(discount.activationDate);
    controller.setDeactivationDate(discount.deactivationDate);

    if (discount is DiscountOfByEntity) {
      howMuchPayEC.text = discount.howMuckPay.toString();
      controller.setDiscountType(DiscountType.ofBy);
    } else if (discount is DiscountPercentageEntity) {
      percentageDiscountEC.text = discount.percentage.toString();
      controller.setDiscountType(DiscountType.percentage);
    } else if (discount is DiscountTakesPaidEntity) {
      amountTakesEC.text = discount.amountTakes.toString();
      amountPaidEC.text = discount.amountPaid.toString();
      controller.setDiscountType(DiscountType.takePay);
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
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    CustomTextField(
                      controller: titleEC,
                      validator: controller.validateTitle,
                      label: 'Nome do desconto',
                    ),
                    CustomTextField(
                      controller: descriptionEC,
                      validator: controller.validateDescription,
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
                                      prefixText: "R\$ ",
                                      keyboardType: TextInputType.number,
                                      validator: controller.validatePrice,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CentavosInputFormatter(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: howMuchPayEC,
                                      label: 'Preço "POR"',
                                      prefixText: "R\$ ",
                                      keyboardType: TextInputType.number,
                                      validator: controller.validatePrice,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CentavosInputFormatter(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            if (controller.discountType == DiscountType.percentage)
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: priceEC,
                                      label: 'Preço',
                                      prefixText: "R\$ ",
                                      keyboardType: TextInputType.number,
                                      validator: controller.validatePrice,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CentavosInputFormatter(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: percentageDiscountEC,
                                      label: 'Percentual de desconto',
                                      prefixText: "% ",
                                      keyboardType: TextInputType.number,
                                      validator: controller.validatePercent,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CentavosInputFormatter(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            if (controller.discountType == DiscountType.takePay) ...[
                              CustomTextField(
                                controller: priceEC,
                                label: 'Preço',
                                prefixText: "R\$ ",
                                keyboardType: TextInputType.number,
                                validator: controller.validatePrice,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CentavosInputFormatter(),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: amountTakesEC,
                                      label: 'Leve',
                                      keyboardType: TextInputType.number,
                                      validator: controller.validateTakesPaid,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: amountPaidEC,
                                      label: 'Pague',
                                      keyboardType: TextInputType.number,
                                      validator: controller.validateTakesPaid,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
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
                            Expanded(
                              child: InkWell(
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
                                        child: Text(activationDate?.toString() ?? '__/__/____'),
                                      ),
                                    ],
                                  )),
                            ),
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
                                      child: Text(deactivationDate?.toString() ?? '__/__/____'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
                    child: Observer(
                      builder: (_) {
                        return ElevatedButton(
                          onPressed: () async {
                            final validate = formKey.currentState?.validate() ?? false;
                            if (!validate) return;

                            final activationDate = controller.activationDate;
                            final deactivationDate = controller.deactivationDate;

                            if (activationDate == null || deactivationDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Escolha a data para o desconto')),
                              );
                              return;
                            }

                            final product = ProductEntity(
                              id: widget.product.id,
                              title: titleEC.text,
                              price: double.parse(priceEC.text.replaceAll(',', '.')),
                              category: widget.product.category,
                              description: descriptionEC.text,
                              image: widget.product.image,
                            );

                            DiscountEntity discount;
                            final id = widget.discount?.id ?? DateTime.now().millisecondsSinceEpoch;
                            switch (controller.discountType) {
                              case DiscountType.ofBy:
                                discount = DiscountOfByEntity(
                                  id: id,
                                  product: product,
                                  activationDate: activationDate,
                                  deactivationDate: deactivationDate,
                                  howMuckPay: double.parse(howMuchPayEC.text.replaceAll(',', '.')),
                                );
                                break;
                              case DiscountType.percentage:
                                discount = DiscountPercentageEntity(
                                  id: id,
                                  product: product,
                                  activationDate: activationDate,
                                  deactivationDate: deactivationDate,
                                  percentage: double.parse(
                                    percentageDiscountEC.text.replaceAll(',', '.'),
                                  ),
                                );
                                break;
                              case DiscountType.takePay:
                                discount = DiscountTakesPaidEntity(
                                  id: id,
                                  product: product,
                                  activationDate: activationDate,
                                  deactivationDate: deactivationDate,
                                  amountPaid: int.parse(amountPaidEC.text),
                                  amountTakes: int.parse(amountTakesEC.text),
                                );
                                break;
                              default:
                                throw Exception('Not found Disconte Type Data');
                            }
                            widget.discount != null
                                ? await Modular.get<DiscountController>().updateDiscount(discount)
                                : await Modular.get<DiscountController>().createDiscount(discount);
                            Modular.to.pushNamedAndRemoveUntil('/discount', (p0) => false);
                          },
                          child: Text(widget.discount != null ? 'Atualizar' : 'Salvar'),
                        );
                      },
                    ),
                  ),
                ],
              ),
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
