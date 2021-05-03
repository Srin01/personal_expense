import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense1/models/Transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense1/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  double get totalSpending {
    print(recentTransactions);
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dateTime.day == weekday.day &&
            recentTransactions[i].dateTime.month == weekday.month) {
          totalSum += recentTransactions[i].price;
        }
      }
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map((e) =>  Flexible(
            fit: FlexFit.tight,
                child: ChartBar(
                        label: e['day'],
                        spendingAmount: e['amount'],
                        spendingPctOfTotal: totalSpending == 0
                            ? 0
                            : (e["amount"] as double) / totalSpending,
                      ),
              ),
              )
              .toList(),
        ),
      );
  }
}
