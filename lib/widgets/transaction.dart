import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction extends StatelessWidget {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final Function deleteTx;

  const Transaction(
      {super.key,
      required this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(child: Text('\$${amount.toStringAsFixed(2)}'))),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(DateFormat.yMMMMEEEEd().format(date),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            )),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () => {deleteTx(id)},
        ),
      ),
    );
    //     Card(
    // elevation: 5,
    // child: Row(
    //   children: [
    //     Container(
    //       margin: const EdgeInsets.all(10),
    //       padding: const EdgeInsets.all(10),
    //       decoration: BoxDecoration(
    //         border: Border.all(
    //           color: Theme.of(context).primaryColor,
    //           width: 2,
    //         ),
    //       ),
    //       child: Text(
    //         '\$${amount.toStringAsFixed(2)}',
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 20,
    //           color: Theme.of(context).primaryColor,
    //         ),
    //       ),
    //     ),
    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(title,
    //             style: const TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //             )),
    //         Text(DateFormat.yMMMMEEEEd().format(date),
    //             style: const TextStyle(
    //               fontSize: 14,
    //               color: Colors.grey,
    //             )),
    //       ],
    //     )
    //   ],
    // ));
  }
}
