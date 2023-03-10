import 'package:flutter/material.dart';

Future<bool> showAddNewDialog(
  BuildContext context, {
  required TextEditingController expenseNameController,
  required TextEditingController expenseAmountController,
  required GlobalKey<FormState> formKey,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Add new expense',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // expense name
              TextFormField(
                controller: expenseNameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a name for expense!';
                  } else {
                    return null;
                  }
                },
              ),

              const SizedBox(height: 10),

              // expense amount
              TextFormField(
                controller: expenseAmountController,
                /* keyboardType: const TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                ), */
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                ),
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      int.tryParse(value) == null) {
                    return 'Invalid amount!';
                  } else if (value == null || value.isEmpty) {
                    return 'Enter an amount of expense!';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          MaterialButton(
            child: const Text('Save'),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      );
    },
  );
}
