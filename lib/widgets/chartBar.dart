import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(
      {required this.label,
      required this.spendingAmount,
      required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 80,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 1.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
