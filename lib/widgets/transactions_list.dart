import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionsList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      // used when we use listview inside a column
      itemBuilder: (context, index) {
        return ListTile(
            leading: Container(
              width: 60,
              height: 60,
              child: Center(
                  child: Text(
                '\$${transactions[index].amout.toStringAsFixed(2)}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
            ),
            title: Text(
              '${transactions[index].title}',
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle:
                Text('${DateFormat.yMMMd().format(transactions[index].date)}'),
            trailing: IconButton(
                icon: Icon(Icons.delete_forever, color: Colors.red),
                onPressed: () => removeTransaction(index)));
      },
      itemCount: transactions.length,
      separatorBuilder: (context, int) => Divider(
        height: 1,
        thickness: 1,
      ),
    );
  }
}
