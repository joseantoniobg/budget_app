import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

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
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                            'R\$${transactions[index].value.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    '${transactions[index].description}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(DateFormat('dd/MM/yyyy')
                      .format(transactions[index].date)),
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
                          onPressed: () => _deleteTx(transactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => _deleteTx(transactions[index].id),
                        ),
                ),
              );
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
            },
            itemCount: transactions.length,
          );
  }
}
