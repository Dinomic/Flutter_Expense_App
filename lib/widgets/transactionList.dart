import 'package:flutter/material.dart';
import 'package:Flutter_Expense_App/widgets/transaction.dart';
import 'package:Flutter_Expense_App/models/transactionModel.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactionList;
  final Function deleteTransaction;

  const TransactionList(
      {super.key,
      required this.transactionList,
      required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: transactionList.isEmpty
            ? Column(
                children: [
                  const Text(
                    'transaction list empty',
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Transaction(
                    id: transactionList.elementAt(index).id,
                    title: transactionList.elementAt(index).title,
                    amount: transactionList.elementAt(index).amount,
                    date: transactionList.elementAt(index).date,
                    deleteTx: deleteTransaction,
                  );
                },
                itemCount: transactionList.length,
              ));
  }
}
