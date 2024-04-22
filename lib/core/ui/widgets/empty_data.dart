import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  final String title;
  final String content;
  const EmptyData({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Text(content),
        ],
      ),
    );
  }
}
