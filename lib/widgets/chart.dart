import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: 6 - index),
      );
      double dailyAmmount = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        dailyAmmount +=
            (DateFormat('dd/MM/yyyy').format(recentTransactions[i].date) ==
                    DateFormat('dd/MM/yyyy').format(weekDay)
                ? recentTransactions[i].value
                : 0);
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': dailyAmmount
      };
    }) /*.reversed.toList()*/;
  }

  double get totalExpenses {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: (recentTransactions.length == 0
                ? [
                    Container(
                      height: 30,
                      child: Card(
                        child: Text(
                          'No Transactions in this Week Yet...',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ]
                : groupedTransactionsValues.map((data) {
                    return Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(data['day'], data['amount'],
                          (data['amount'] as double) / totalExpenses),
                    );
                  }).toList()),
          ),
          totalExpenses == 0
              ? SizedBox(
                  height: 10,
                )
              : Container(
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                        totalExpenses == 0
                            ? ''
                            : 'Total Week amount: R\$ ${totalExpenses.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans')),
                  ),
                )
        ]),
      ),
    );
  }
}
