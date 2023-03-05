import 'package:expense_planner/widgets/Chart_Bar.dart';
import 'package:flutter/material.dart';
import '../models/Transactoin.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get getTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
        ;
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get TotalSpending {
    return getTransactionValue.fold(
        0.0, (sum, element) => sum + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    print(getTransactionValue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...getTransactionValue.map(
              (data) {
                return Expanded(
                    child: ChartBar(
                        data['day'] as String,
                        data['amount'] as double,
                        TotalSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / TotalSpending));
              },
            ).toList()
          ],
        ),
      ),
    );
  }
}
