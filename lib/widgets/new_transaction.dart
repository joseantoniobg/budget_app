import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(20),
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
            ),
            FlatButton(
              onPressed: () {
                addTransaction(descriptionController.text,
                    double.parse(amountController.text));
              },
              child: Text('Add Transaction'),
              textColor: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
