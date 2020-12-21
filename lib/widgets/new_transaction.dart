import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  void submitData() {
    final enteredTitle = descriptionController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty && enteredAmount > 0) {
      addTransaction(enteredTitle, enteredAmount);
    }
  }

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
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              onPressed: () => submitData(),
              child: Text('Add Transaction'),
              textColor: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
