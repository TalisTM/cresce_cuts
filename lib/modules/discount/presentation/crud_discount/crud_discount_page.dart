import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/ui/helpers/messages_helper.dart';
import '../../../../core/ui/themes/app_themes.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/entities/discount_entity.dart';
import '../../domain/entities/discount_of_by_entity.dart';
import '../../domain/entities/discount_percentage_entity.dart';
import '../../domain/entities/discount_takes_paid_entity.dart';
import 'crud_discount_controller.dart';
import 'widgets/select_discount_date_widget.dart';
import 'widgets/select_discount_type_button.dart';

class CrudDiscountPage extends StatefulWidget {
  final DiscountEntity? discount;
  final ProductEntity product;
  const CrudDiscountPage({super.key, this.discount, required this.product});

  @override
  State<CrudDiscountPage> createState() => _CrudDiscountPageState();
}

class _CrudDiscountPageState extends State<CrudDiscountPage> with MessageHelper<CrudDiscountPage> {
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
    priceEC.text = UtilBrasilFields.obterReal(widget.product.price);

    final discount = widget.discount;
    if (discount == null) return;

    controller.setActivationDate(discount.activationDate);
    controller.setDeactivationDate(discount.deactivationDate);

    if (discount is DiscountOfByEntity) {
      howMuchPayEC.text = UtilBrasilFields.obterReal(discount.howMuckPay);
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
        title: const Text('Cadastro desconto'),
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
                      label: 'Nome desconto',
                    ),
                    CustomTextField(
                      padding: const EdgeInsets.only(top: 20),
                      controller: descriptionEC,
                      validator: controller.validateDescription,
                      label: 'Descrição',
                      maxLines: 4,
                    ),
                    Observer(
                      builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectDiscountTypeButton(
                              discountType: controller.discountType,
                              onChanged: (value) => controller.setDiscountType(value),
                            ),
                            if (controller.discountType == DiscountType.ofBy)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d*\.?\d*$'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            if (controller.discountType == DiscountType.takePay) ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                              const SizedBox(height: 20),
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
                            ],
                          ],
                        );
                      },
                    ),
                    Observer(
                      builder: (_) {
                        return SelectDiscountDateWidget(
                          activationDate: controller.activationDate,
                          deactivationDate: controller.deactivationDate,
                          onActivationDate: controller.setActivationDate,
                          onDeactivationDate: controller.setDeactivationDate,
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Observer(
                            builder: (_) {
                              return ElevatedButton(
                                onPressed: () {
                                  final validate = formKey.currentState?.validate() ?? false;
                                  if (!validate) return;

                                  final activationDate = controller.activationDate;
                                  final deactivationDate = controller.deactivationDate;

                                  if (activationDate == null || deactivationDate == null) {
                                    showCustomSnackBar('Escolha a data para o desconto');
                                    return;
                                  }

                                  controller.onConfirm(
                                    oldDiscount: widget.discount,
                                    oldProduct: widget.product,
                                    title: titleEC.text,
                                    price: priceEC.text,
                                    description: descriptionEC.text,
                                    activationDate: activationDate,
                                    deactivationDate: deactivationDate,
                                    howMuchPay: howMuchPayEC.text,
                                    percentageDiscount: percentageDiscountEC.text,
                                    amountPaid: amountPaidEC.text,
                                    amountTakes: amountTakesEC.text,
                                  );
                                },
                                child: Text(widget.discount != null ? 'Atualizar' : 'Salvar'),
                              );
                            },
                          ),
                        ),
                        if (widget.discount != null) ...[
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppThemes.red),
                            onPressed: () {
                              showCustomDialog(
                                'Apagar desconto',
                                content: 'Realmente deseja apagar o desconto?',
                                textPrimaryButton: 'Confirmar',
                                textSecondaryButton: 'Cancelar',
                                onPressedPrimaryButton: () => controller.onDelete(widget.discount!),
                              );
                            },
                            child: const Icon(Icons.delete),
                          )
                        ],
                      ],
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
}
