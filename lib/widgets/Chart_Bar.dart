import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    const Color BlueColor = Colors.grey;
    final Color primaryColor = Theme.of(context).primaryColor;
    final BorderRadius roundedBorder = BorderRadius.circular(10);

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 1.0),
                color: BlueColor,
                borderRadius: roundedBorder,
              ),
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1.0),
                      color: BlueColor,
                      borderRadius: roundedBorder,
                    ),
                  ),
                  FractionallySizedBox(
                      heightFactor: spendingPctOfTotal,
                      child: Container(
                          decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: roundedBorder,
                      )))
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
