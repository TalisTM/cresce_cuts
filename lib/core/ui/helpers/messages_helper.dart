import 'package:flutter/material.dart';

mixin MessageHelper<T extends StatefulWidget> on State<T> {
  Future<bool?> showCustomDialog(
    String title, {
    String? content,
    String? textPrimaryButton,
    String? textSecondaryButton,
    VoidCallback? onPressedPrimaryButton,
    VoidCallback? onPressedSecondaryButton,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
            ),
            if (content != null)
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(content, style: Theme.of(context).textTheme.bodySmall),
              ),
            const SizedBox(height: 30),
            Row(
              children: [
                if (textSecondaryButton != null)
                  Expanded(
                    child: TextButton(
                      onPressed: onPressedSecondaryButton ?? () => Navigator.pop(context),
                      child: Text(
                        textSecondaryButton,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                if (textPrimaryButton != null)
                  Expanded(
                    child: TextButton(
                      onPressed: onPressedPrimaryButton ?? () => Navigator.pop(context),
                      child: Text(
                        textPrimaryButton,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showCustomSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
