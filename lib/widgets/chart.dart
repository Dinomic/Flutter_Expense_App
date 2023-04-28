import 'package:Flutter_Expense_App/models/transactionModel.dart';
import 'package:Flutter_Expense_App/models/chartEntryModel.dart';

import 'package:Flutter_Expense_App/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<TransactionModel> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<ChartEntryModel> get groupedTransactions {
    return List.generate(7, (index) {
      final DateTime weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions.elementAt(i).date.day == weekDay.day &&
            recentTransactions.elementAt(i).date.month == weekDay.month &&
            recentTransactions.elementAt(i).date.year == weekDay.year) {
          totalSum += recentTransactions.elementAt(i).amount;
        }
      }

      return ChartEntryModel(
          weekDay: DateFormat.E().format(weekDay).toString(),
          totalAmount: totalSum);
    }).reversed.toList();
  }

  double get groupedTotalSpending {
    return groupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + element.totalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...groupedTransactions.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: e.weekDay,
                    spendingAmount: e.totalAmount,
                    spendingPctOfTotal: groupedTotalSpending == 0
                        ? 0
                        : e.totalAmount / groupedTotalSpending),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
