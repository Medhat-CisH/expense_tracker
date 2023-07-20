import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Categoty { food, travel, leisure, work }

const categoryIcons = {
  Categoty.food: Icons.lunch_dining,
  Categoty.travel: Icons.flight_takeoff,
  Categoty.leisure: Icons.movie,
  Categoty.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.categoty})
      : id = uuid.v4();

  final String id, title;
  final double amount;
  final DateTime date;
  final Categoty categoty;

  String get formattedDate => formatter.format(date);
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.categoty == category)
            .toList();
  final Categoty category;
  final List<Expense> expenses;
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }
    return sum;
  }
}
