import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function Addtx;

  NewTransaction(this.Addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //const NewTransaction({super.key});
  final _titleController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();
  final _amountController = TextEditingController();

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmmount = double.parse(_amountController.text);
    if (enteredAmmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }

    widget.Addtx(
      enteredTitle,
      enteredAmmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                  ), //start from here)
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    // onChanged: (value) => ammountInput = value,
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(),
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(_selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                        ),
                        TextButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: _presentDatePicker)
                      ],
                    ),
                  ),

                  ElevatedButton(
                      onPressed: _submitData,
                      child: Text(
                        'Submit Transaction',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.purple),
                      ))
                ])));
  }
}
