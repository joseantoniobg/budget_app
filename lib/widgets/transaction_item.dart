import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTx;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.purple,
      Color.fromARGB(255, 255, 120, 60),
    ];

    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$${widget.transaction.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.description,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle:
            Text(DateFormat('dd/MM/yyyy').format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                onPressed: () => widget.deleteTx(widget.transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              ),
      ),
    );
  }
}
