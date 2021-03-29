import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double amount;
  final double spendingPC;

  const ChartBar({this.lable, this.amount, this.spendingPC});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text('\$${amount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            width: 10,
            height: constraints.maxHeight * 0.6,
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  color: Colors.black26,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                )),
                FractionallySizedBox(
                  heightFactor: spendingPC,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(lable)),
          )
        ],
      );
    });
  }
}
