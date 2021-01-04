import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _submitData() {
    final _enteredTitle = descriptionController.text;
    final _enteredAmount = double.parse(amountController.text);

    if (_enteredTitle.isNotEmpty &&
        _enteredAmount > 0 &&
        _selectedDate != null) {
      widget.addTransaction(_enteredTitle, _enteredAmount, _selectedDate);
    }

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 20)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Description:'),
                //onChanged: (val) => descriptionInput = val,
                controller: descriptionController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount:'),
                //onChanged: (val) => amountInput = val,
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
                    ),
                    AdaptiveFlatButton(
                        'Choose Date',
                        _presentDatePicker,
                        TextStyle(fontWeight: FontWeight.bold),
                        Theme.of(context).primaryColor),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () => _submitData(),
                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
