import 'package:flutter/material.dart';

import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1',
        description: 'New Shoes from Converse',
        value: 200,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        description: 'Weekly Groceries',
        value: 16.57,
        date: DateTime.now())
  ];

  void _addNewTransaction(String description, double amount) {
    Transaction t = new Transaction(
        id: DateTime.now().toString(),
        description: description,
        value: amount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(t);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
