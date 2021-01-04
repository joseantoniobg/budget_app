import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTx;

  TransactionList(this.transactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.length == 0
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nothing here yet...',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView(children: [
            ...transactions
                .map((e) => TransactionItem(
                    key: ValueKey(e.id), transaction: e, deleteTx: _deleteTx))
                .toList()
          ]);

    // ListView.builder(
    //   itemBuilder: (ctx, index) {
    //     return TransactionItem(
    //       transactions[index],
    //       _deleteTx,
    //     );
    //   },
    //   itemCount: transactions.length,
    // );

    // return Container(
    //   padding: EdgeInsets.only(left: 10, right: 10),
    //   child: Card(
    //       elevation: 5,
    //       child: Row(children: <Widget>[
    //         Container(
    //           margin: EdgeInsets.symmetric(
    //               vertical: 10, horizontal: 20),
    //           decoration: BoxDecoration(
    //               border: Border.all(
    //             color: Theme.of(context).primaryColorDark,
    //             width: 2,
    //           )),
    //           padding: EdgeInsets.all(10),
    //           child: Text(
    //             'R\$ ${transactions[index].value.toStringAsFixed(2)}',
    //             style: Theme.of(context).textTheme.title,
    //           ),
    //         ),
    //         Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 transactions[index].description,
    //                 style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //               Text(
    //                 DateFormat('dd/MM/yyyy')
    //                     .format(transactions[index].date),
    //                 style: TextStyle(color: Colors.grey),
    //               )
    //             ]),
    //       ])),
    // );
  }
}
