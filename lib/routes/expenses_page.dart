import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expenses_list/expenses_list.dart';
import '../widgets/new_expense.dart';
import '../widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        categoty: Categoty.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        categoty: Categoty.leisure),
    Expense(
        title: 'Pizza',
        amount: 10.20,
        date: DateTime.now(),
        categoty: Categoty.food),
    Expense(
        title: 'Going Work',
        amount: 20.28,
        date: DateTime.now(),
        categoty: Categoty.travel)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Removed.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent =
        const Center(child: Text('No Expenses found. Start adding some!'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
          child: width < 600
              ? Column(
                  children: [
                    // Toolbar with the add Button => Row() (AppBar)
                    Chart(
                      expenses: _registeredExpenses,
                    ),
                    Expanded(child: mainContent)
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Chart(
                        expenses: _registeredExpenses,
                      ),
                    ),
                    Expanded(child: mainContent)
                  ],
                )),
    );
  }
}
