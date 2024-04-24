import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/ui/themes/app_themes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Cresce Cuts",
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
    );
  }
}
