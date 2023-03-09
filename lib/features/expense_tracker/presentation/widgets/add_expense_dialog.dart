import 'package:flutter/material.dart';

Future<bool> showAddNewDialog(
  BuildContext context, {
  required TextEditingController expenseNameController,
  required TextEditingController expenseAmountController,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: expenseNameController,
            ),

            // expense amount
            TextField(
              controller: expenseAmountController,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            child: const Text('Save'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          MaterialButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      );
    },
  );
}
