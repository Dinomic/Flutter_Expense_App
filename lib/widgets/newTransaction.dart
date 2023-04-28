import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submidData() {
    String inputTitle = _titleController.text;
    double inputAmount = double.parse(_amountController.text);

    if (inputTitle.isEmpty || inputAmount <= 0) {
      return;
    }

    widget.addNewTransaction(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate!,
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(_selectedDate == null
                        ? 'No date chosen!'
                        : DateFormat.yMd().format(_selectedDate!).toString())),
                TextButton(
                    onPressed: _showDatePicker,
                    child: const Text('Choose date')),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                  // style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(
                  //         Color.fromARGB(255, 12, 70, 118)),
                  //     foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: _submidData,
                  child: const Text('Add Transaction')),
            ),
          ],
        ),
      ),
    );
  }
}
