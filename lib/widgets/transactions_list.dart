import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionsList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Center(
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Text(
                      'No Transactions',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/no_transactions.png'))
                ],
              ),
            );
          })
        : ListView.builder(
            shrinkWrap: true,
            // used when we use listview inside a column
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(5),
                child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.all(5),
                      child: Center(
                          child: Text(
                        '\$${transactions[index].amout.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                    ),
                    title: Text(
                      '${transactions[index].title}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        '${DateFormat.yMMMd().format(transactions[index].date)}'),
                    trailing: IconButton(
                        icon: Icon(Icons.delete_forever, color: Colors.red),
                        onPressed: () => removeTransaction(index))),
              );
            },
            itemCount: transactions.length);
  }
}
