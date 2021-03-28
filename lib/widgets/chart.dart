import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactions
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      lable: e['day'],
                      amount: e['amount'] == null ? 0.0 : e['amount'],
                      spendingPC: totalSpending == 0.0
                          ? 0.0
                          : ((e['amount'] as double) / totalSpending),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  double get totalSpending {
    return recentTransactions.fold(
        0.0, (previousValue, element) => previousValue + element.amout);
  }

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          sum += recentTransactions[i].amout;
      }
      return {'day': DateFormat.E().format(weekDay).substring(0,1), 'amount': sum};
    }).reversed.toList();
  }
}
