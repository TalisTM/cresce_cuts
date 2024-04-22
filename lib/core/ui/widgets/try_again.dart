import 'package:flutter/material.dart';

class TryAgain extends StatelessWidget {
  final String title;
  final VoidCallback tryAgain;
  const TryAgain({super.key, required this.title, required this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: tryAgain, child: const Text("Tente novamente")),
          ],
        ),
      ),
    );
  }
}
