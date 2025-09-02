import 'package:flutter/material.dart';

Future<void> showCustomModal({
  required BuildContext context,
  required String title,
  required Widget content,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Wrap(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              content,
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}
