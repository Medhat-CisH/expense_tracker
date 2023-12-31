import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('${expense.amount.toStringAsFixed(2)} EGP'
                  // 12.3433 => 12.34
                  ),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.categoty]),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(expense.formattedDate)
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
