import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'product_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final controller = Modular.get<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductPage'),
      ),
      body: Container(),
    );
  }
}
