import 'package:Flutter_Expense_App/models/transactionModel.dart';

import 'package:Flutter_Expense_App/widgets/transactionList.dart';
import 'package:Flutter_Expense_App/widgets/newTransaction.dart';
import 'package:Flutter_Expense_App/widgets/chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.pink, fontFamily: 'Quicksand'),
      home: const MyHomePage(title: 'Espense App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TransactionModel> _transactions = [
    TransactionModel(
        id: 0, title: 'Laptop', amount: 19.99, date: DateTime.now()),
    TransactionModel(
        id: 1, title: 'Shoes', amount: 34.99, date: DateTime.now()),
    TransactionModel(id: 2, title: 'House', amount: 657, date: DateTime.now()),
    TransactionModel(id: 3, title: 'Car', amount: 12, date: DateTime.now()),
  ];

  int _currentMaxId = 3;

  List<TransactionModel> get _lastSevenDayTransaction {
    return _transactions.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    _currentMaxId += 1;
    TransactionModel newTx = TransactionModel(
      id: _currentMaxId,
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(int id) {
    setState(() {
      _transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _showNewTransactionAddingSection(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(addNewTransaction: _addNewTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [IconButton(onPressed: () => {}, icon: const Icon(Icons.add))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(recentTransactions: _lastSevenDayTransaction),
          TransactionList(
            transactionList: _transactions,
            deleteTransaction: _deleteTransaction,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewTransactionAddingSection(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
